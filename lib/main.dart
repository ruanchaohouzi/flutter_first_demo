import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_first_demo/page/painter_page.dart';
import 'package:flutter_first_demo/page/user_page.dart';
import 'package:flutter_first_demo/page/weather_page.dart';
import 'package:flutter_first_demo/utils/http_util.dart';
import 'package:flutter_first_demo/test/news_detail.dart';
import 'package:flutter_first_demo/page/news_page.dart';
import 'package:flutter_first_demo/page/secondPage.dart';
import 'package:flutter_first_demo/page/secondPage_native.dart';
import 'package:flutter_first_demo/page/thirdPage.dart';
import 'package:flutter_first_demo/page/main6.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_first_demo/routers/routes.dart';

void main(){
  debugPaintSizeEnabled = false;
  runApp(_widgetForRoute(window.defaultRouteName));
}


Widget _widgetForRoute(String route){
  switch(route){
    case "flutter_view1":
      break;
    case "flutter_view2":
      break;
    default:
      return new HomePage();
  }
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  List<Widget> tabs = [];
  List tabData = [
    {'text': '首页', 'icon': 'a1.png'},
    {'text': '画板', 'icon': 'a2.png'},
    {'text': '天气', 'icon': 'a3.png'}
  ];
  TabController controller;
  var appBarTitle;

  _HomePageState(){
    final router = new Router();
    Routes.configureRoutes(router);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 3; i++) {
      tabs.add(Container(
        height: 80.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset("images/" + tabData[i]['icon']),
            Text(tabData[i]['text'], textDirection: TextDirection.ltr),
          ],
        ),
      ));
    }

    appBarTitle = tabData[0];
    controller = new TabController(length: 3, vsync: this, initialIndex: 0);
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTapChange();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: "demo",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      onGenerateRoute:Routes.router.generator,
      home: new Scaffold(
        body: new TabBarView(controller: controller, children: <Widget>[
            new NewsPage(),
            new PainterPage(),
            new WeatherPage()
          ],
        ),
        bottomNavigationBar: Material(
            color: Colors.black12,
            child: Container(
              height: 80.0,
              child: TabBar(
                isScrollable: false,
                tabs: tabs,
                controller: controller,
                indicatorWeight: 0.1,
//                indicator: null,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
              ),
            )),
      ),
    );
  }

  void _onTapChange() {
    setState(() {
      appBarTitle = tabData[controller.index];
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future test() async{
    Map<String, dynamic> responseData;
    Map params = {"id":12,"name":"wendu"};
    //采取try catch 捕捉请求失败的信息
    try {
      responseData = await HttpUtil().get("/test", params);
    }on DioError catch(e){
      if(e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else{
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
    responseData = await HttpUtil().post("/test", params);
    //表单提交
    FormData formData = new FormData.from({
      "name": "wendux",
      "age": 25,
    });
    responseData = await HttpUtil().post("/info", formData);
  }
}
