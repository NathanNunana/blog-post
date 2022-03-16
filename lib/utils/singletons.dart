part of blog_utils;

class Singletons {
  static final _blogService = BlogService();

  static List<BlocProvider> registerCubit() => [
        BlocProvider<BlogCubit>(
          create: (_) => BlogCubit(blogService: _blogService),
        ),
        BlocProvider<UploadCubit>(
          create: (_) => UploadCubit(blogService: _blogService),
        )
      ];
}
