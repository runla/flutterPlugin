import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_demo/my_plugin_demo.dart';
import 'package:my_plugin_demo/my_plugin_demo_platform_interface.dart';
import 'package:my_plugin_demo/my_plugin_demo_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyPluginDemoPlatform 
    with MockPlatformInterfaceMixin
    implements MyPluginDemoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyPluginDemoPlatform initialPlatform = MyPluginDemoPlatform.instance;

  test('$MethodChannelMyPluginDemo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyPluginDemo>());
  });

  test('getPlatformVersion', () async {
    MyPluginDemo myPluginDemoPlugin = MyPluginDemo();
    MockMyPluginDemoPlatform fakePlatform = MockMyPluginDemoPlatform();
    MyPluginDemoPlatform.instance = fakePlatform;
  
    expect(await MyPluginDemo.getPlatformVersion(), '42');
  });
}
