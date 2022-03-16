part of 'upload_blog_cubit.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState.initial() = _initial;
  const factory UploadState.uploading() = _uploading;
  const factory UploadState.uploaded() = _uploaded;
  const factory UploadState.error({
    required String message,
  }) = _error;
}
