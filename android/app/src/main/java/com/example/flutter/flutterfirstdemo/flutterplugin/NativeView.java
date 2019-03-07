package com.example.flutter.flutterfirstdemo.flutterplugin;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

//Flutter的原生View不能直接继承自View，需要实现提供的PlatformView接口
public class NativeView implements PlatformView,MethodChannel.MethodCallHandler {

    TextView myNativeView;
    Context context;
    Map<String,String> params;
    MethodChannel methodChannel;

    public NativeView(Context context, int id, BinaryMessenger messenger, Object obj){
        this.context = context;
        params = (Map) obj;
        //布局必须要在这里初始化，否则回调可能设置的数据被覆盖了
        myNativeView = new TextView(context);
        methodChannel = new MethodChannel(messenger,"com.example.flutter.flutterfirstdemo.flutterplugin.NativeView");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        //接受来自Flutter中的参数
        String text = params.get("data") + params.get("desc");
        myNativeView.setText(text);
        return myNativeView;
    }

    @Override
    public void dispose() {

    }

    /**
     * 接受Flutter中的回调参数
     * @param methodCall
     * @param result
     */
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

        if ("setUserText".equals(methodCall.method)) {
            String text = (String) methodCall.arguments;
            Log.i("NativeView","NativeView:" + text);
            myNativeView.setText(text);
            result.success(null);
        }
    }
}
