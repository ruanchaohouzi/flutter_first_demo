import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_demo/model/weather.dart';
import 'package:flutter_first_demo/utils/http_util.dart';

class WeatherPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeatherPageState();
  }

}

class WeatherPageState extends State<WeatherPage> with AutomaticKeepAliveClientMixin{

  final String WeatherAppKey = "41b4845e8183e58ef69f0852ffc07547";
  Weather weather;
  var city = "";

  MethodChannel channel= new MethodChannel("app.channel.shared.data");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherResult();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("天气预报")),
      body: ListView(
        children: <Widget>[
          getHeadWidget(),
          Container(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(

                child: Text("本周天气", style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
          getFutureWeatherWidget(),
          getTemperatureTrend(),
        ],
      ),
    );
  }

  Widget getFutureWeatherWidget(){

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Expanded(child: getDayWidget(0)),
          Expanded(child: getDayWidget(1)),
          Expanded(child: getDayWidget(2)),
          Expanded(child: getDayWidget(3)),
          Expanded(child: getDayWidget(4)),
        ],
      ),);
  }

  Widget getDayWidget(int index){
    String week = "";
    String dateShow = "";
    String weatherShow = "";
    String temperatureShow = "";
    if(weather != null){
      var date = weather?.result.future[index].date;
      DateTime dateTime = DateTime.parse(date);
      int weekday = dateTime.weekday;
      week = getWeek(weekday);
      dateShow = date.substring(5);
      weatherShow = weather.result.future[index].weather;
      temperatureShow = weather.result.future[index].temperature;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5.0), child: Text(week),),
          Padding(padding: EdgeInsets.all(5.0), child: Text(dateShow),),
          Padding(padding: EdgeInsets.all(5.0), child: Text(weatherShow),),
          Padding(padding: EdgeInsets.all(5.0), child: Image.asset("images/sun.png",fit: BoxFit.contain,),),
          Padding(padding: EdgeInsets.all(5.0), child: Text(temperatureShow),),
        ],
      ),
    );
}

  Future getWeatherResult() async{
    if(Platform.isAndroid) {
      city = await channel.invokeMethod("getCity");
    }else{
      city = "杭州";
    }
    Map<String, dynamic> weatherResponse = await HttpUtil().get("http://apis.juhe.cn/simpleWeather/query?city=${Uri.encodeFull(city)}&key=$WeatherAppKey", null);
    setState(() {
      print("weatherResponse:${weatherResponse}");
      weather = Weather.fromJson(weatherResponse);
    });
  }

  Widget getTemperatureTrend() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: getTemperatureTrendChild(),
    );
  }

  Widget getTemperatureTrendChild(){
    if(weather != null){
      return CustomPaint(painter: TemperatureTrendPainter(MediaQuery.of(context).size.width, weather.result.future));
    }else{
      return Container();
    }
  }

  String getWeek(int weekday) {
    switch(weekday){
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      case 7:
        return "星期日";
      default:
        return "星期日";
        break;
    }
  }

  Widget getHeadWidget() {

    return Container(
      width: MediaQuery.of(context).size.width,
      child:Stack(
        children: <Widget>[
          Image.asset("images/head_img.jpg",fit: BoxFit.fitWidth,),
          Padding(padding: EdgeInsets.only(left: 50,top: 30),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$city",style: TextStyle(
                      fontSize: 70.0,
                      color: Colors.white
                  )),
                  Row(
                    children: <Widget>[
                      Text("${weather?.result?.realtime?.temperature}°",
                        style: TextStyle(
                            fontSize: 70.0,
                            color: Colors.white
                        ),),
                      Text("${weather?.result?.realtime?.info}",style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                      ),)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("${weather?.result?.realtime?.direct}",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white
                        ),),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${weather?.result?.realtime?.power}",style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;}

class TemperatureTrendPainter extends CustomPainter{

  double width;
  List<FutureWeather> futureWeatherList;
  List temperatures = [];
  Paint painter = new Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..filterQuality = FilterQuality.high
    ..style = PaintingStyle.stroke;

  TemperatureTrendPainter(double width, List<FutureWeather> futureWeatherList){
    this.width = width;
    this.futureWeatherList = futureWeatherList;
    for(int i = 0; i<futureWeatherList.length; i++){
      List temperDay =  new List();
      var temperature = futureWeatherList[i].temperature.split("/");
      temperDay.add(int.parse(temperature[0]));
      temperDay.add(int.parse(temperature[1].split("℃")[0]));
      temperatures.add(temperDay);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {

    Offset offset0 = new Offset(getXposition(0), getYposition(0));
    Offset offset1 = new Offset(getXposition(1), getYposition(1));
    Offset offset2 = new Offset(getXposition(2), getYposition(2));
    Offset offset3 = new Offset(getXposition(3), getYposition(3));
    Offset offset4 = new Offset(getXposition(4), getYposition(4));
    List<Offset> points = [offset0,offset1,offset2,offset3,offset4];

    canvas.drawPoints(PointMode.polygon, points, painter);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double getXposition(int index){
    var cellWidth = width/5.0;
    return index * cellWidth + cellWidth /2.0;

  }

  double getYposition(int index){
    return (30 - ((temperatures[index][0] + temperatures[index][1])/2.0))*4;
  }

}
