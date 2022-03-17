import 'package:bloc/bloc.dart';
import 'package:blog_post/models/_index.dart';
import 'package:blog_post/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'upload_blog_cubit.freezed.dart';
part 'upload_blog_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit({
    required BlogService blogService,
  }) : super(const UploadState.initial()) {
    _blogService = blogService;
  }

  late BlogService _blogService;
  Future<void> uploadPost({
    required String title,
    required String details,
    required String imageUrl,
  }) async {
    try {
      emit(const UploadState.uploading());
      final posts = await _blogService.addItems(
        blogPost: BlogDataDTO(
          title: title,
          details: details,
          image: imageUrl,
        ),
      );
      Logger().d('Posts: $posts');
      emit(const UploadState.uploaded());
    } on Failure catch (error) {
      emit(UploadState.error(message: error.toString()));
    } catch (err) {
      Logger().e(err);
      emit(const UploadState.error(message: 'Server error'));
    }
  }
}
