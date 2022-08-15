import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_plugin_demo_method_channel.dart';

abstract class MyPluginDemoPlatform extends PlatformInterface {
  /// Constructs a MyPluginDemoPlatform.
  MyPluginDemoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyPluginDemoPlatform _instance = MethodChannelMyPluginDemo();

  /// The default instance of [MyPluginDemoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyPluginDemo].
  static MyPluginDemoPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyPluginDemoPlatform] when
  /// they register themselves.
  static set instance(MyPluginDemoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
