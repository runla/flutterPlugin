
import 'package:my_plugin_demo/api/Api.dart';
import 'package:my_plugin_demo/model/AccessToken.dart';

import 'my_plugin_demo_platform_interface.dart';
import 'network/request.dart';

class MyPluginDemo {
  static Future<void> init() async{
    // 初始化网络配置
    print("MyPluginDemo init");
    dio.config(Api.baseUrl);
  }



  static Future<String?> authenticate(String jwtToken) async {
    AccessToken? token = await Api.getAccessToken(jwtToken);
    return token?.accessToken ?? "";
  }


  static Future<String?> getPlatformVersion() {
    return MyPluginDemoPlatform.instance.getPlatformVersion();
  }
}
