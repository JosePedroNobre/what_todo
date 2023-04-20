import 'package:dio/dio.dart';
import 'dio_logger.dart';

final Dio dio = Dio();

class ApiNetworkInterceptor extends Interceptor {
  static String tag = 'services_base_api';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };

    options.headers.addAll(headers);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DioLogger.onSuccess(tag, response);
    super.onResponse(response, handler);
  }

  @override
  dynamic onError(DioError err, ErrorInterceptorHandler handler) {
    DioLogger.onError(tag, err);

    throw err;
  }
}

class ApiService {
  static ApiService shared = ApiService();
  static String baseURL = 'https://jsonplaceholder.typicode.com/';

  ApiService() {
    if (dio.interceptors.whereType<ApiNetworkInterceptor>().isEmpty) {
      dio.interceptors.add(ApiNetworkInterceptor());
    }

    dio.options.baseUrl = baseURL;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);
  }

  Future<dynamic> post(String url, {dynamic body, Map<String, dynamic>? queryParams}) async {
    return await dio.post(url, data: body, queryParameters: queryParams);
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(url, queryParameters: queryParameters);
  }

  Future<dynamic> put(String url, {dynamic body}) async {
    return await dio.put(url, data: body);
  }

  Future<dynamic> patch(String url, {dynamic body}) async {
    return await dio.patch(url, data: body);
  }

  Future<dynamic> delete(String url) async {
    return await dio.delete(url);
  }
}
