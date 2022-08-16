import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:my_plugin_demo/network/respone_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:network_logger/network_logger.dart';

import '../api/Api.dart';
import 'default_interceptor.dart';

BaseOptions options = BaseOptions(
  baseUrl: Api.baseUrl,
  connectTimeout: 10000,
  receiveTimeout: 20000,
);

var dio = Dio(options);

extension DioExt on Dio {

  static CacheOptions? cacheOptions;
  //网络缓存配置
  static Future<CacheOptions> _getCacheOptions() async {
    // Global options
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    final cacheOptions = CacheOptions(
      store: HiveCacheStore(tempPath),        // Required.
      policy: CachePolicy.refreshForceCache,  // Default. Checks cache freshness, requests otherwise and caches response.
      hitCacheOnErrorExcept: [],              // Optional. Returns a cached response on error if available but for statuses 401 & 403.
      priority: CachePriority.normal,         // Optional. Default. Allows 3 cache sets and ease cleanup.
      maxStale: const Duration(days: 7),      // Very optional. Overrides any HTTP directive to delete entry past this duration.
    );
    DioExt.cacheOptions = cacheOptions;
    return cacheOptions;
  }

  /// 项目网络初始化相关配置
  Future<void> config(String baseUrl) async {
    print("MyPluginDemo config start");
    final cacheOptions = await _getCacheOptions();
    dio.options.baseUrl = baseUrl;
    // 注入header默认拦截器
    dio.interceptors
      ..add(HeaderInterceptor())
      ..add(DioCacheInterceptor(options: cacheOptions));
    // 只在非release下才开启log
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    // 网络请求log
    dio.interceptors.add(DioNetworkLogger());
    print("MyPluginDemo config end");

  }
}

extension ResponseExtend on Response {
  /// 解析respone对象
  ResponeMessage? responeMessage<T>() {
    try {
      final source = toString();
      final srcJson = jsonDecode(source);
      return ResponeMessage(true, "success", 0, srcJson);
    } catch (e) {
      print(e);
      return ResponeMessage(false, e.toString(), -1, null);
    }
  }
  /// 解析respone对象
  ResponeMessage? responeError<T>() {
    try {
      final source = toString();
      final srcJson = jsonDecode(source);
      print("responeError = $source");
      return ResponeMessage.fromErrorJson(srcJson);
    } catch (e) {
      print(e);
      return ResponeMessage(false, e.toString(), -1, null);
    }
  }


}

/// HTTP请求类型
enum HTTPMethod { POST, GET }

Future<ResponeMessage?> requestPost(
    String path, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Options? options}) async{

  options ??= Options();
  if (headers != null) {
    options.headers = headers;
  }

  return request(path, method: HTTPMethod.POST, data: data, queryParameters: queryParameters, options: options);
}


/// 发起网络请求、隐藏dio
Future<ResponeMessage?> request(
  String path, {
  HTTPMethod method = HTTPMethod.POST,
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CachePolicy policy = CachePolicy.refreshForceCache,
  CancelToken? cancelToken,
}) async {
  try {
    Response response;
    options = options ?? DioExt.cacheOptions?.copyWith(policy: policy).toOptions();
    if(dio.interceptors.isEmpty) {
      // 注入header默认拦截器
      dio.interceptors
        ..add(DioNetworkLogger())
        ..add(LogInterceptor(requestBody: true, responseBody: true))
        ..add(HeaderInterceptor());
    }

    if (method == HTTPMethod.POST) {
      print("request queryParameters = $queryParameters");
      response = await dio.post(path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);
      print("POST response = $response");
    } else {
      response = await dio.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
      print("GET response = $response");
    }
    return response.responeMessage();
  } catch (e) {
    if(e is DioError) {
      Response? errorResponse = e.response;
      return errorResponse?.responeError();
    }
    print("error--------- $e");
    return Future.error(e);
  }
}
