part of blog_services;

abstract class BlogApiService {
  Future<List<BlogData>> getPosts();
  Future<List<BlogData>> addItems({
    required BlogDataDTO blogPost,
  });
}

class BlogService implements BlogApiService {
  final _networkUtil = NetworkUtil();
  final _baseUrl = BlogConfig.instance!.values.baseUrl;
  @override
  Future<List<BlogData>> getPosts() async {
    final _apiUrl = '$_baseUrl/posts';
    try {
      final _res = await _networkUtil.getReq(_apiUrl);
      return BlogDataList.fromJson(_res).data;
    } on FormatException {
      throw const Failure(
        message: 'Bad response format',
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BlogData>> addItems({required BlogDataDTO blogPost}) async {
    final _apiUrl = '$_baseUrl/posts';
    try {
      final _res = await _networkUtil.postReq(
        _apiUrl,
        body: blogPost,
      );
      return [BlogData.fromJson(_res)];
    } on FormatException {
      throw const Failure(message: 'Bad response format');
    } catch (error) {
      rethrow;
    }
  }
}
