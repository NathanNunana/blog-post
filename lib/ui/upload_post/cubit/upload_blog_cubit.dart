import 'package:bloc/bloc.dart';
import 'package:blog_post/models/_index.dart';
import 'package:blog_post/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'upload_blog_cubit.freezed.dart';
part 'upload_blog_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit({
    required this.blogService,
  }) : super(const UploadState.initial());

  BlogService blogService;
  Future<void> uploadPost({
    required BlogDataDTO blogPost,
  }) async {
    try {
      emit(const UploadState.uploading());
      final posts = await blogService.addItems(blogPost: blogPost);
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
