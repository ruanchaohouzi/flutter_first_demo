package com.example.flutter.flutterfirstdemo.flutterplugin;

import io.flutter.plugin.common.PluginRegistry;

public class NativeViewFlutterPlugin {

    public static void registerWith(PluginRegistry registry){

        String key = NativeViewFlutterPlugin.class.getCanonicalName();

        if (registry.hasPlugin(key)){
            return;
        }
        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry()
                .registerViewFactory("com.example.flutter.flutterfirstdemo.flutterplugin.NativeView",
                        new NativeViewFactory(registrar.messenger()));

    }
}
