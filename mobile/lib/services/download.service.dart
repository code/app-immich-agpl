import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/constants/constants.dart';
import 'package:immich_mobile/domain/models/store.model.dart';
import 'package:immich_mobile/entities/asset.entity.dart';
import 'package:immich_mobile/entities/store.entity.dart';
import 'package:immich_mobile/models/download/livephotos_medatada.model.dart';
import 'package:immich_mobile/repositories/download.repository.dart';
import 'package:immich_mobile/repositories/file_media.repository.dart';
import 'package:immich_mobile/services/api.service.dart';
import 'package:logging/logging.dart';

final downloadServiceProvider = Provider(
  (ref) => DownloadService(ref.watch(fileMediaRepositoryProvider), ref.watch(downloadRepositoryProvider)),
);

class DownloadService {
  final DownloadRepository _downloadRepository;
  final FileMediaRepository _fileMediaRepository;
  final Logger _log = Logger("DownloadService");
  void Function(TaskStatusUpdate)? onImageDownloadStatus;
  void Function(TaskStatusUpdate)? onVideoDownloadStatus;
  void Function(TaskStatusUpdate)? onLivePhotoDownloadStatus;
  void Function(TaskProgressUpdate)? onTaskProgress;

  DownloadService(this._fileMediaRepository, this._downloadRepository) {
    _downloadRepository.onImageDownloadStatus = _onImageDownloadCallback;
    _downloadRepository.onVideoDownloadStatus = _onVideoDownloadCallback;
    _downloadRepository.onLivePhotoDownloadStatus = _onLivePhotoDownloadCallback;
    _downloadRepository.onTaskProgress = _onTaskProgressCallback;
  }

  void _onTaskProgressCallback(TaskProgressUpdate update) {
    onTaskProgress?.call(update);
  }

  void _onImageDownloadCallback(TaskStatusUpdate update) {
    onImageDownloadStatus?.call(update);
  }

  void _onVideoDownloadCallback(TaskStatusUpdate update) {
    onVideoDownloadStatus?.call(update);
  }

  void _onLivePhotoDownloadCallback(TaskStatusUpdate update) {
    onLivePhotoDownloadStatus?.call(update);
  }

  Future<bool> saveImageWithPath(Task task) async {
    final filePath = await task.filePath();
    final title = task.filename;
    final relativePath = Platform.isAndroid ? 'DCIM/Immich' : null;
    try {
      final Asset? resultAsset = await _fileMediaRepository.saveImageWithFile(
        filePath,
        title: title,
        relativePath: relativePath,
      );
      return resultAsset != null;
    } catch (error, stack) {
      _log.severe("Error saving image", error, stack);
      return false;
    } finally {
      if (await File(filePath).exists()) {
        await File(filePath).delete();
      }
    }
  }

  Future<bool> saveVideo(Task task) async {
    final filePath = await task.filePath();
    final title = task.filename;
    final relativePath = Platform.isAndroid ? 'DCIM/Immich' : null;
    final file = File(filePath);
    try {
      final Asset? resultAsset = await _fileMediaRepository.saveVideo(file, title: title, relativePath: relativePath);
      return resultAsset != null;
    } catch (error, stack) {
      _log.severe("Error saving video", error, stack);
      return false;
    } finally {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<bool> saveLivePhotos(Task task, String livePhotosId) async {
    final records = await _downloadRepository.getLiveVideoTasks();
    if (records.length < 2) {
      return false;
    }

    final imageRecord = _findTaskRecord(records, livePhotosId, LivePhotosPart.image);
    final videoRecord = _findTaskRecord(records, livePhotosId, LivePhotosPart.video);
    final imageFilePath = await imageRecord.task.filePath();
    final videoFilePath = await videoRecord.task.filePath();

    try {
      final result = await _fileMediaRepository.saveLivePhoto(
        image: File(imageFilePath),
        video: File(videoFilePath),
        title: task.filename,
      );

      return result != null;
    } on PlatformException catch (error, stack) {
      // Handle saving MotionPhotos on iOS
      if (error.code == 'PHPhotosErrorDomain (-1)') {
        final result = await _fileMediaRepository.saveImageWithFile(imageFilePath, title: task.filename);
        return result != null;
      }
      _log.severe("Error saving live photo", error, stack);
      return false;
    } catch (error, stack) {
      _log.severe("Error saving live photo", error, stack);
      return false;
    } finally {
      final imageFile = File(imageFilePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }

      final videoFile = File(videoFilePath);
      if (await videoFile.exists()) {
        await videoFile.delete();
      }

      await _downloadRepository.deleteRecordsWithIds([imageRecord.task.taskId, videoRecord.task.taskId]);
    }
  }

  Future<bool> cancelDownload(String id) async {
    return await FileDownloader().cancelTaskWithId(id);
  }

  Future<List<bool>> downloadAll(List<Asset> assets) async {
    return await _downloadRepository.downloadAll(assets.expand(_createDownloadTasks).toList());
  }

  Future<void> download(Asset asset) async {
    final tasks = _createDownloadTasks(asset);
    await _downloadRepository.downloadAll(tasks);
  }

  List<DownloadTask> _createDownloadTasks(Asset asset) {
    if (asset.isImage && asset.livePhotoVideoId != null && Platform.isIOS) {
      return [
        _buildDownloadTask(
          asset.remoteId!,
          asset.fileName,
          group: kDownloadGroupLivePhoto,
          metadata: LivePhotosMetadata(part: LivePhotosPart.image, id: asset.remoteId!).toJson(),
        ),
        _buildDownloadTask(
          asset.livePhotoVideoId!,
          asset.fileName.toUpperCase().replaceAll(RegExp(r"\.(JPG|HEIC)$"), '.MOV'),
          group: kDownloadGroupLivePhoto,
          metadata: LivePhotosMetadata(part: LivePhotosPart.video, id: asset.remoteId!).toJson(),
        ),
      ];
    }

    if (asset.remoteId == null) {
      return [];
    }

    return [
      _buildDownloadTask(
        asset.remoteId!,
        asset.fileName,
        group: asset.isImage ? kDownloadGroupImage : kDownloadGroupVideo,
      ),
    ];
  }

  DownloadTask _buildDownloadTask(String id, String filename, {String? group, String? metadata}) {
    final path = r'/assets/{id}/original'.replaceAll('{id}', id);
    final serverEndpoint = Store.get(StoreKey.serverEndpoint);
    final headers = ApiService.getRequestHeaders();

    return DownloadTask(
      taskId: id,
      url: serverEndpoint + path,
      headers: headers,
      filename: filename,
      updates: Updates.statusAndProgress,
      group: group ?? '',
      metaData: metadata ?? '',
    );
  }
}

TaskRecord _findTaskRecord(List<TaskRecord> records, String livePhotosId, LivePhotosPart part) {
  return records.firstWhere((record) {
    final metadata = LivePhotosMetadata.fromJson(record.task.metaData);
    return metadata.id == livePhotosId && metadata.part == part;
  });
}
