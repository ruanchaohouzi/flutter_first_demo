import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeatherPageState();
  }

}

class WeatherPageState extends State<WeatherPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("天气预报")),
      body: ListView(
        children: <Widget>[
          Text("112321"),
          Text("112321"),
          Text("112321"),
          Text("112321"),
        ],
      ),
    );
  }

}