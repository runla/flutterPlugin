package com.simple.my_plugin_demo

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** MyPluginDemoPlugin */
class MyPluginDemoPlugin: FlutterPlugin, MethodCallHandler {
  companion object {
    private const val TAG = "MyPlugin"
    const val CHANNEL_NAME = "my_plugin_demo"
    const val VIEW_TYPE_ID = "plugins.flutter.io/custom_platform_view"

    private const val sGetPlatformVersion = "getPlatformVersion"

  }


  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this)

    val messenger: BinaryMessenger = flutterPluginBinding.binaryMessenger
    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory(VIEW_TYPE_ID, MyFlutterViewFactory(messenger))

  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == sGetPlatformVersion) {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
