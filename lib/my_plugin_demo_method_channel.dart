import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_plugin_demo_platform_interface.dart';

/// An implementation of [MyPluginDemoPlatform] that uses method channels.
class MethodChannelMyPluginDemo extends MyPluginDemoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin_demo');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
