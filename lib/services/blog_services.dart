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
    try {
      print('${_apiUrl.toString()}/posts');
      final _res = await _networkUtil.getReq('$_apiUrl/posts');
      print(_res);
      return BlogDataList.fromJson(_res).data;
    } on FormatException {
      throw const Failure(message: 'Bad response format');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<BlogData>> addItems({required BlogDataDTO blogPost}) async {
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
