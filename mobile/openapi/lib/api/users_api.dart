//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UsersApi {
  UsersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// This endpoint requires the `userProfileImage.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<Response> createProfileImageWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/profile-image';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(apiPath));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      apiPath,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userProfileImage.update` permission.
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<CreateProfileImageResponseDto?> createProfileImage(MultipartFile file,) async {
    final response = await createProfileImageWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateProfileImageResponseDto',) as CreateProfileImageResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userProfileImage.delete` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteProfileImageWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/profile-image';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userProfileImage.delete` permission.
  Future<void> deleteProfileImage() async {
    final response = await deleteProfileImageWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// This endpoint requires the `userLicense.delete` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteUserLicenseWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/license';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userLicense.delete` permission.
  Future<void> deleteUserLicense() async {
    final response = await deleteUserLicenseWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// This endpoint requires the `userOnboarding.delete` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteUserOnboardingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/onboarding';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userOnboarding.delete` permission.
  Future<void> deleteUserOnboarding() async {
    final response = await deleteUserOnboardingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// This endpoint requires the `userPreference.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMyPreferencesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/preferences';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userPreference.read` permission.
  Future<UserPreferencesResponseDto?> getMyPreferences() async {
    final response = await getMyPreferencesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserPreferencesResponseDto',) as UserPreferencesResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `user.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMyUserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `user.read` permission.
  Future<UserAdminResponseDto?> getMyUser() async {
    final response = await getMyUserWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserAdminResponseDto',) as UserAdminResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userProfileImage.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getProfileImageWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/{id}/profile-image'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userProfileImage.read` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<MultipartFile?> getProfileImage(String id,) async {
    final response = await getProfileImageWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MultipartFile',) as MultipartFile;
    
    }
    return null;
  }

  /// This endpoint requires the `user.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getUserWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `user.read` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<UserResponseDto?> getUser(String id,) async {
    final response = await getUserWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserResponseDto',) as UserResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userLicense.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUserLicenseWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/license';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userLicense.read` permission.
  Future<LicenseResponseDto?> getUserLicense() async {
    final response = await getUserLicenseWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LicenseResponseDto',) as LicenseResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userOnboarding.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUserOnboardingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/onboarding';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userOnboarding.read` permission.
  Future<OnboardingResponseDto?> getUserOnboarding() async {
    final response = await getUserOnboardingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'OnboardingResponseDto',) as OnboardingResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `user.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> searchUsersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `user.read` permission.
  Future<List<UserResponseDto>?> searchUsers() async {
    final response = await searchUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<UserResponseDto>') as List)
        .cast<UserResponseDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// This endpoint requires the `userLicense.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LicenseKeyDto] licenseKeyDto (required):
  Future<Response> setUserLicenseWithHttpInfo(LicenseKeyDto licenseKeyDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/license';

    // ignore: prefer_final_locals
    Object? postBody = licenseKeyDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userLicense.update` permission.
  ///
  /// Parameters:
  ///
  /// * [LicenseKeyDto] licenseKeyDto (required):
  Future<LicenseResponseDto?> setUserLicense(LicenseKeyDto licenseKeyDto,) async {
    final response = await setUserLicenseWithHttpInfo(licenseKeyDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LicenseResponseDto',) as LicenseResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userOnboarding.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [OnboardingDto] onboardingDto (required):
  Future<Response> setUserOnboardingWithHttpInfo(OnboardingDto onboardingDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/onboarding';

    // ignore: prefer_final_locals
    Object? postBody = onboardingDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userOnboarding.update` permission.
  ///
  /// Parameters:
  ///
  /// * [OnboardingDto] onboardingDto (required):
  Future<OnboardingResponseDto?> setUserOnboarding(OnboardingDto onboardingDto,) async {
    final response = await setUserOnboardingWithHttpInfo(onboardingDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'OnboardingResponseDto',) as OnboardingResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `userPreference.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserPreferencesUpdateDto] userPreferencesUpdateDto (required):
  Future<Response> updateMyPreferencesWithHttpInfo(UserPreferencesUpdateDto userPreferencesUpdateDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me/preferences';

    // ignore: prefer_final_locals
    Object? postBody = userPreferencesUpdateDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `userPreference.update` permission.
  ///
  /// Parameters:
  ///
  /// * [UserPreferencesUpdateDto] userPreferencesUpdateDto (required):
  Future<UserPreferencesResponseDto?> updateMyPreferences(UserPreferencesUpdateDto userPreferencesUpdateDto,) async {
    final response = await updateMyPreferencesWithHttpInfo(userPreferencesUpdateDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserPreferencesResponseDto',) as UserPreferencesResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `user.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserUpdateMeDto] userUpdateMeDto (required):
  Future<Response> updateMyUserWithHttpInfo(UserUpdateMeDto userUpdateMeDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/users/me';

    // ignore: prefer_final_locals
    Object? postBody = userUpdateMeDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `user.update` permission.
  ///
  /// Parameters:
  ///
  /// * [UserUpdateMeDto] userUpdateMeDto (required):
  Future<UserAdminResponseDto?> updateMyUser(UserUpdateMeDto userUpdateMeDto,) async {
    final response = await updateMyUserWithHttpInfo(userUpdateMeDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserAdminResponseDto',) as UserAdminResponseDto;
    
    }
    return null;
  }
}
