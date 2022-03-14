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
    // /b/7V5D
    final _baseUrl = '$_apiUrl/b/B7IO';
    try {
      // print('https://621ff28ece99a7de194c95b9.mockapi.io/posts');
      final _res = await _networkUtil.getReq('https://jsonkeeper.com/b/SFQ6');
      print(_res);
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
        '$_apiUrl/posts',
        body: blogPost.toString(),
      );
      return BlogDataList.fromJson(_res).data;
    } on FormatException {
      throw const Failure(message: 'Bad response format');
    } catch (error) {
      rethrow;
    }
  }
}
