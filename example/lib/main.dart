import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_plugin_demo/my_plugin_demo.dart';

import 'AuthCode.dart';

void main(){
  // 初始化
  // MyPluginDemo.init();

  runApp(const MyApp());

}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _accessToken = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    authience();
  }

  Future<void> authience() async {
    String jwtToken = AuthCode.getAuthCode();
    String accessToken = await MyPluginDemo.init()
            .then((value) => MyPluginDemo.authenticate(jwtToken)) ?? "Unknown";
    setState(() {
      _accessToken = accessToken;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await MyPluginDemo.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget platformView() {
      if(defaultTargetPlatform == TargetPlatform.android) {
        return MyPluginDemo.androidTextView("Flutter to Android TextView");
      }
      return Text('Running on: $_platformVersion\n_accessToken: $_accessToken');
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          RaisedButton(
            child: Text("传递参数给原生 View"),
          onPressed: () {

          })
        ],),
      ),
    );
  }
}
