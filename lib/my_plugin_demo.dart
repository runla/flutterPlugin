
import 'my_plugin_demo_platform_interface.dart';

class MyPluginDemo {
  Future<String?> getPlatformVersion() {
    return MyPluginDemoPlatform.instance.getPlatformVersion();
  }
}
