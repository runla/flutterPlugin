import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_plugin_demo_method_channel.dart';

abstract class MyPluginDemoPlatform extends PlatformInterface {

  MyPluginDemoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyPluginDemoPlatform _instance = MethodChannelMyPluginDemo();
  static MyPluginDemoPlatform get instance => _instance;


  static set instance(MyPluginDemoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw _instance.getPlatformVersion();
  }

  void setText(String text);

}
