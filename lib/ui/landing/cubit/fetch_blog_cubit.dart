// Project imports
import 'package:bloc/bloc.dart';
import 'package:blog_post/models/_index.dart';
import 'package:blog_post/services/_index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'fetch_blog_state.dart';
part 'fetch_blog_cubit.freezed.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit({required BlogService blogService})
      : super(const BlogState.initial()) {
    _blogService = blogService;
  }
  late final BlogService _blogService;

  Future<void> fetchBlogPost() async {
    try {
      emit(const BlogState.loading());
      final posts = await _blogService.getPosts();
      Logger().d('Posts: $posts');
      emit(BlogState.loaded(posts));
    } on Failure catch (error) {
      emit(BlogState.error(error.message));
    } catch (err) {
      Logger().e(err);
      emit(const BlogState.error('An unexpected error occured'));
    }
  }
}
