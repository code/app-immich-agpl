import { extname } from 'node:path';
import { AssetType } from 'src/enum';

const raw: Record<string, string[]> = {
  '.3fr': ['image/3fr', 'image/x-hasselblad-3fr'],
  '.ari': ['image/ari', 'image/x-arriflex-ari'],
  '.arw': ['image/arw', 'image/x-sony-arw'],
  '.cap': ['image/cap', 'image/x-phaseone-cap'],
  '.cin': ['image/cin', 'image/x-phantom-cin'],
  '.cr2': ['image/cr2', 'image/x-canon-cr2'],
  '.cr3': ['image/cr3', 'image/x-canon-cr3'],
  '.crw': ['image/crw', 'image/x-canon-crw'],
  '.dcr': ['image/dcr', 'image/x-kodak-dcr'],
  '.dng': ['image/dng', 'image/x-adobe-dng'],
  '.erf': ['image/erf', 'image/x-epson-erf'],
  '.fff': ['image/fff', 'image/x-hasselblad-fff'],
  '.iiq': ['image/iiq', 'image/x-phaseone-iiq'],
  '.k25': ['image/k25', 'image/x-kodak-k25'],
  '.kdc': ['image/kdc', 'image/x-kodak-kdc'],
  '.mrw': ['image/mrw', 'image/x-minolta-mrw'],
  '.nef': ['image/nef', 'image/x-nikon-nef'],
  '.nrw': ['image/nrw', 'image/x-nikon-nrw'],
  '.orf': ['image/orf', 'image/x-olympus-orf'],
  '.ori': ['image/ori', 'image/x-olympus-ori'],
  '.pef': ['image/pef', 'image/x-pentax-pef'],
  '.psd': ['image/psd', 'image/vnd.adobe.photoshop'],
  '.raf': ['image/raf', 'image/x-fuji-raf'],
  '.raw': ['image/raw', 'image/x-panasonic-raw'],
  '.rw2': ['image/rw2', 'image/x-panasonic-rw2'],
  '.rwl': ['image/rwl', 'image/x-leica-rwl'],
  '.sr2': ['image/sr2', 'image/x-sony-sr2'],
  '.srf': ['image/srf', 'image/x-sony-srf'],
  '.srw': ['image/srw', 'image/x-samsung-srw'],
  '.x3f': ['image/x3f', 'image/x-sigma-x3f'],
};

/**
 * list of supported image extensions from https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Image_types excluding svg
 * @TODO share with the client
 * @see {@link web/src/lib/utils/asset-utils.ts#L329}
 **/
const webSupportedImage = {
  '.avif': ['image/avif'],
  '.gif': ['image/gif'],
  '.jpeg': ['image/jpeg'],
  '.jpg': ['image/jpeg'],
  '.png': ['image/png', 'image/apng'],
  '.webp': ['image/webp'],
};

const image: Record<string, string[]> = {
  ...raw,
  ...webSupportedImage,
  '.bmp': ['image/bmp'],
  '.heic': ['image/heic'],
  '.heif': ['image/heif'],
  '.hif': ['image/hif'],
  '.insp': ['image/jpeg'],
  '.jp2': ['image/jp2'],
  '.jpe': ['image/jpeg'],
  '.jxl': ['image/jxl'],
  '.svg': ['image/svg'],
  '.tif': ['image/tiff'],
  '.tiff': ['image/tiff'],
};

const extensionOverrides: Record<string, string> = {
  'image/jpeg': '.jpg',
};

const profileExtensions = new Set(['.avif', '.dng', '.heic', '.heif', '.jpeg', '.jpg', '.png', '.webp', '.svg']);
const profile: Record<string, string[]> = Object.fromEntries(
  Object.entries(image).filter(([key]) => profileExtensions.has(key)),
);

const video: Record<string, string[]> = {
  '.3gp': ['video/3gpp'],
  '.3gpp': ['video/3gpp'],
  '.avi': ['video/avi', 'video/msvideo', 'video/vnd.avi', 'video/x-msvideo'],
  '.flv': ['video/x-flv'],
  '.insv': ['video/mp4'],
  '.m2t': ['video/mp2t'],
  '.m2ts': ['video/mp2t'],
  '.m4v': ['video/x-m4v'],
  '.mkv': ['video/x-matroska'],
  '.mov': ['video/quicktime'],
  '.mp4': ['video/mp4'],
  '.mpe': ['video/mpeg'],
  '.mpeg': ['video/mpeg'],
  '.mpg': ['video/mpeg'],
  '.mts': ['video/mp2t'],
  '.vob': ['video/mpeg'],
  '.webm': ['video/webm'],
  '.wmv': ['video/x-ms-wmv'],
};

const sidecar: Record<string, string[]> = {
  '.xmp': ['application/xml', 'text/xml'],
};

const types = { ...image, ...video, ...sidecar };

const isType = (filename: string, r: Record<string, string[]>) => extname(filename).toLowerCase() in r;

const lookup = (filename: string) => types[extname(filename).toLowerCase()]?.[0] ?? 'application/octet-stream';
const toExtension = (mimeType: string) => {
  return (
    extensionOverrides[mimeType] || Object.entries(types).find(([, mimeTypes]) => mimeTypes.includes(mimeType))?.[0]
  );
};

export const mimeTypes = {
  image,
  profile,
  sidecar,
  video,
  raw,

  isAsset: (filename: string) => isType(filename, image) || isType(filename, video),
  isImage: (filename: string) => isType(filename, image),
  isWebSupportedImage: (filename: string) => isType(filename, webSupportedImage),
  isProfile: (filename: string) => isType(filename, profile),
  isSidecar: (filename: string) => isType(filename, sidecar),
  isVideo: (filename: string) => isType(filename, video),
  isRaw: (filename: string) => isType(filename, raw),
  lookup,
  /** return an extension (including a leading `.`) for a mime-type */
  toExtension,
  assetType: (filename: string) => {
    const contentType = lookup(filename);
    if (contentType.startsWith('image/')) {
      return AssetType.Image;
    } else if (contentType.startsWith('video/')) {
      return AssetType.Video;
    }
    return AssetType.Other;
  },
  getSupportedFileExtensions: () => [...Object.keys(image), ...Object.keys(video)],
};
