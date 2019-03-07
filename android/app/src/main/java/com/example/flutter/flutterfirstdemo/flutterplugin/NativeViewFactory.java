package com.example.flutter.flutterfirstdemo.flutterplugin;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NativeViewFactory extends PlatformViewFactory {

    MessageCodec<Object> createArgsCodec;
    BinaryMessenger messenger;

    public NativeViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.createArgsCodec = createArgsCodec;
        this.messenger = messenger;
    }

    /**
     *
     * @param context
     * @param id
     * @param obj obj是由Flutter传过来的自定义参数
     * @return
     */
    @Override
    public PlatformView create(Context context, int id, Object obj) {
        return new NativeView(context, id, messenger,obj);
    }
}
