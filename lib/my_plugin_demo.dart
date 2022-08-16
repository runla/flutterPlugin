
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_plugin_demo/api/Api.dart';
import 'package:my_plugin_demo/model/AccessToken.dart';

import 'my_plugin_demo_platform_interface.dart';
import 'network/request.dart';

class MyPluginDemo {
  static const String VIEW_TYPE_ID = "plugins.flutter.io/custom_platform_view";

  static Future<void> init() async{
    // 初始化网络配置
    print("MyPluginDemo init");
    dio.config(Api.baseUrl);
  }


  static Widget androidTextView(String text) {
    return AndroidView(viewType: VIEW_TYPE_ID,
        creationParams: {'text': text} ,
        creationParamsCodec: const StandardMessageCodec());
  }

  static Future<String?> authenticate(String jwtToken) async {
    AccessToken? token = await Api.getAccessToken(jwtToken);
    return token?.accessToken ?? "";
  }


  static Future<String?> getPlatformVersion() {
    return MyPluginDemoPlatform.instance.getPlatformVersion();
  }


  static setText(String text) {
    MyPluginDemoPlatform.instance.setText(text);
  }
}
