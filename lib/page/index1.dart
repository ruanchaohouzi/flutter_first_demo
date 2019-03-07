import 'dart:ui';
import 'package:flutter/material.dart';

class index1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _index1State();
  }

}

class _index1State extends State<index1>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Padding(
          padding: EdgeInsets.all(30.0),
          child: new Text(
            "index1",
            textDirection: TextDirection.ltr,
            style: new TextStyle(color: Colors.red, fontSize: 30.0),
          )),
    );;
  }

}