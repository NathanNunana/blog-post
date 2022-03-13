part of blog_utils;

class NetworkUtil {
  final _logger = Logger();
  Dio _getHttpClient() {
    final _dio = Dio(
      BaseOptions(
        baseUrl: BlogConfig._instance!.values.baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{'Accept': 'application/json'},
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    );
    return _dio;
  }

  Future<Map<String, dynamic>> getReq(String url) async {
    try {
      final _response = await _getHttpClient().get<dynamic>(url);
      print('network: $_response');
      final _responseBody = _response.data as Map<String, dynamic>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (error) {
      if (DioErrorType.response == error.type) {
        _logger
          ..d('Error: ${error.toString()}')
          ..i('${error.response?.statusCode}')
          ..i('Error: ${error.response?.data}');
      } else if (DioErrorType.connectTimeout == error.type) {
        throw const SocketException('No internet connection');
      }
      throw const Failure(message: 'Server error');
    }
  }

  Future<Map<String, dynamic>> postReq(
    String url, {
    required String body,
  }) async {
    try {
      final _response = await _getHttpClient().post<dynamic>(url, data: body);
      final _responseBody = _response.data as Map<String, String>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (error) {
      if (DioErrorType.response == error.type) {
        _logger
          ..d('Error ${error.toString()}')
          ..i('${error.response?.statusCode}')
          ..i('Error: ${error.response?.data}');
      }
      if (error.response?.statusCode == 401) {
        throw const Failure(message: 'Unauthorized');
      } else if (DioErrorType.connectTimeout == error.type) {
        throw const Failure(message: 'No internet connection');
      }
      throw const Failure(message: 'Server error');
    }
  }
}
