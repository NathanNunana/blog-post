part of blog_utils;

class BlogValues {
  BlogValues({required this.baseUrl});
  String baseUrl;
}

class BlogConfig {
  factory BlogConfig({
    required BlogValues values,
  }) {
    return _instance ??= BlogConfig._internal(values);
  }
  BlogConfig._internal(this.values);

  final BlogValues values;
  static BlogConfig? _instance;

  static BlogConfig? get instance {
    return _instance;
  }
}
