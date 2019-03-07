import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_demo/view/user_view.dart';

class SecondPageNative extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SecondPageNativeState();
  }
}

class SecondPageNativeState extends State<SecondPageNative> {

  MethodChannel _methodChannel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),setTextData);
  }

  Widget getBody(){
    if(defaultTargetPlatform == TargetPlatform.android){

      return AndroidView(viewType: "com.example.flutter.flutterfirstdemo.flutterplugin.NativeView",
        //Flutter向Native层传输参数，
        // creationParams传入了一个map参数，并由原生组件接收，
        // creationParamsCodec传入的是一个编码对象这是固定写法
        creationParams: {"data":"我是来自Flutter中的参数","desc":"我的布局是Native开发的"},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,

      );
    }
    return null;
  }
  
  _onPlatformViewCreated(int id){
    _methodChannel = new MethodChannel("com.example.flutter.flutterfirstdemo.flutterplugin.NativeView");
  }

   Future setTextData() async{
      return _methodChannel.invokeMethod("setUserText","娃哈哈，我是Flutter中Channel的回调数据");
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80.0,
        child: getBody(),
      ),
    );
  }
}