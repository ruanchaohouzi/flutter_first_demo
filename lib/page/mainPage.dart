import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _mainState();
  }
}

class _mainState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'main',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _homePageState();
  }
}

class _homePageState extends State<homePage> {
  static const int SHARE = 1;

  _actionPress(int type) {
    switch (type) {
      case SHARE:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/share.png'),
        title: Text("main", textDirection: TextDirection.ltr),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: Image.asset('images/share.png'),
              onPressed: _actionPress(SHARE))
        ],
      ),
//      body:
    );
  }
}
