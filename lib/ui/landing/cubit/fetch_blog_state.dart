part of 'fetch_blog_cubit.dart';

@freezed
class BlogState with _$BlogState {
  // const BlogState();
  const factory BlogState.initial() = _Initial;
  const factory BlogState.loading() = _Loading;
  const factory BlogState.loaded(List<BlogData> posts) = _Loaded;
  const factory BlogState.error(String message) = _Error;
}

// class BlogInitial extends BlogState {
//   const BlogInitial();
// }

// class BlogLoading extends BlogState {
//   const BlogLoading();
// }

// class BlogLoaded extends BlogState {
//   const BlogLoaded(this.posts);
//   final List<BlogData> posts;
// }

// class BlogError extends BlogState {
//   const BlogError(this.message);
//   final String message;
// }
