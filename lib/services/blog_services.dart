part of blog_services;

abstract class BlogApiService {
  Future<List<BlogData>> getPosts();
  Future<List<BlogData>> addItems({
    required BlogDataDTO blogPost,
  });
}

class BlogService implements BlogApiService {
  final _networkUtil = NetworkUtil();
  final _apiUrl = BlogConfig.instance!.values;
  @override
  Future<List<BlogData>> getPosts() async {
    final _baseUrl = '$_apiUrl/b/SFQ6';
    // https://jsonkeeper.com/b/SFQ6
    try {
      final _res = await _networkUtil
          .getReq('https://623125d705f5f4d40d7466bb.mockapi.io/posts');
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
    final _apiUrl = BlogConfig.instance!.values;
    try {
      final _res = await _networkUtil.postReq(
        'https://623125d705f5f4d40d7466bb.mockapi.io/posts',
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
