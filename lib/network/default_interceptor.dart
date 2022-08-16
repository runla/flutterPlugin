import 'dart:io';

import 'package:dio/dio.dart';

/// 注入网络请求头拦截器
class HeaderInterceptor extends InterceptorsWrapper {
  String? version;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    //注入header请求头
    var headers = options.headers;
    // 设置 accessToken
    // headers['accessToken'] = UserService().currentUser?.accessToken ?? '';

    headers['Accept'] = "application/json;version=1";
    print("request-----url${options.path}");

    super.onRequest(options, handler);
  }
}
