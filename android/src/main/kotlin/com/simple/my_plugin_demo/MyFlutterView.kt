package com.simple.my_plugin_demo

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

/**
 * @description：
 * @author：     chenjianrun
 * @date：       2022/8/16 4:06 下午
 *
 * @param context
 * @param messenger     用于消息传递，后面介绍 Flutter 与 原生通信时用到此参数。
 * @param viewId        View 生成时会分配一个唯一 ID
 * @param args          Flutter 传递的初始化参数
 */
class MyFlutterView(context: Context, messenger: BinaryMessenger, viewId: Int, args: Map<String, Any>?): PlatformView {
    private val textView: TextView = TextView(context)

    init {
        args?.let {
            textView.text = it["text"] as String
        }
    }

    /**
     * 返回要嵌入 Flutter 层次结构的Android View
     */
    override fun getView(): View {
        return textView
    }

    /**
     * 释放此View时调用，此方法调用后 View 不可用，此方法需要清除所有对象引用，否则会造成内存泄漏。
     */
    override fun dispose() {

    }
}