import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(new HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "demo",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new Scaffold(
        appBar: AppBar(title: Text("TestDemo")),
        body: new BodyContain(),
      ),
    );
  }
}

class BodyContain extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BodyContain();
  }
}

class _BodyContain extends State<BodyContain> with AutomaticKeepAliveClientMixin {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  void initState() {
    super.initState();
  }

  titleSection() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex : 2,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("我是主标题,我爱祖国",
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            new Text(
              "副标题，哈哈哈，我是来测试副标题的数据源的",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black26),
            )
          ],
        )),
        new IconButton(
          icon: (_isFavorited
              ? new Icon(Icons.star)
              : new Icon(Icons.star_border)),
          color: Colors.red,
          onPressed: ()=>_toggleFavorite(),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10.0),
          child: new Text(_favoriteCount.toString(),
              textDirection: TextDirection.ltr),
        )
      ],
    );
  }

  _toggleFavorite() {
    print("_toggleFavorite");
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  Column bulidButtonColumn(IconData iconData, String label) {
    return new Column(
      children: <Widget>[
        new Icon(iconData, color: Theme.of(context).primaryColor),
        new Container(
          margin: EdgeInsets.only(top: 12.0),
          child: new Text(label, textDirection: TextDirection.ltr),
        )
      ],
    );
  }

  buttonSection() {
    return new Container(
      margin: EdgeInsets.only(top: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bulidButtonColumn(Icons.accessibility, "Test1"),
          bulidButtonColumn(Icons.ac_unit, "Test2"),
          bulidButtonColumn(Icons.build, "Test3"),
        ],
      ),
    );
  }

  textSection() {
    return new Container(
      margin: EdgeInsets.only(top: 20.0),
      child: new Text(
        "Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake,Lake Oeschinen lies at th one of the larger Alpine Lake walk through pastures and pine forest, leads you to the lake r toboggan run.",
        textDirection: TextDirection.ltr,
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(32.0),
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: new Image.network(
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550053213538&di=b652858653b8ca4534161b56bbafce94&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fc995d143ad4bd11374005bd957afa40f4afb050f.jpg",
                fit: BoxFit.cover,
              ),
            ),
            titleSection(),
            buttonSection(),
            textSection()
          ],
        ),
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
