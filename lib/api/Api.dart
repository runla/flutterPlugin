import 'package:dio/dio.dart';
import 'package:my_plugin_demo/network/request.dart';

import '../model/AccessToken.dart';
import '../network/respone_message.dart';

class Api {
  static const baseUrl = "https://apis-pre-pro.mindlinker.cn/";
  static const accessToken = "passport/api/token?grant_type=thirdparty";

  static Future<AccessToken?> getAccessToken(String jwtToken) async {
    try {
      dynamic data = {
        'authCode': jwtToken,
        'state': 'thirdparty',
        'authType': 'jwt',
        'scope': 'basic'
      };

      Map<String, dynamic> headers = <String, dynamic>{
        'Authorization': "Bearer $jwtToken"
      };

      ResponeMessage? response = await requestPost(Api.accessToken,
          data: data, headers: headers);

      return (response?.success ?? false)
          ? AccessToken.fromJson(response?.result ?? {})
          : null;
    } catch (e) {
      return Future.error(e);
    }
  }
}
