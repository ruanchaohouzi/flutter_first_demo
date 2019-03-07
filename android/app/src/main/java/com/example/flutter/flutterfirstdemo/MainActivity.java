package com.example.flutter.flutterfirstdemo;

import android.os.Bundle;

import com.example.flutter.flutterfirstdemo.flutterplugin.NativeViewFlutterPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    String text = "模拟网络请求数据";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        MethodChannel channel = new MethodChannel(getFlutterView(),
                "app.channel.shared.data"); //回调的接口名称
        channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                //回调的方法名称
                if (methodCall.method.contentEquals("getText")) {
                    //获取flutter传输的参数
                    Object arguments = methodCall.arguments;
                    result.success(text);
                }else if (methodCall.method.contentEquals("getPage")){
                    result.success("main");
                }
            }
        });

        channel.invokeMethod("getData", null, new MethodChannel.Result() {
            @Override
            public void success(Object o) {
            }

            @Override
            public void error(String s, String s1, Object o) {
            }

            @Override
            public void notImplemented() {
            }
        });

        //注册NativeView 在Flutter中使用原生View
        NativeViewFlutterPlugin.registerWith(this);
    }

}
