package com.simple.my_plugin_demo_example

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//        MyPlugin.registerWith(flutterEngine)
    }
}
