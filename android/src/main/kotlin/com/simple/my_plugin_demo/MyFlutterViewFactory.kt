package com.simple.my_plugin_demo

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @description：
 * @author：     chenjianrun
 * @date：       2022/8/16 4:11 下午
 */
class MyFlutterViewFactory (private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return MyFlutterView(context!!, messenger, viewId, args as Map<String, Any>?)
    }

}