#import "MyPluginDemoPlugin.h"
#if __has_include(<my_plugin_demo/my_plugin_demo-Swift.h>)
#import <my_plugin_demo/my_plugin_demo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_plugin_demo-Swift.h"
#endif

@implementation MyPluginDemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyPluginDemoPlugin registerWithRegistrar:registrar];
}
@end
