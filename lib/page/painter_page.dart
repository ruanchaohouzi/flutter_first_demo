import 'dart:typed_data';
import 'dart:ui'as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


Color nowColor = Colors.red;

class PainterPage extends StatelessWidget {

  List<Color> colors = <Color>[
    Colors.redAccent,
    Colors.pink,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.amber,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.cyanAccent,];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("画板")),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 80.0,
              decoration:BoxDecoration(
                  color: Color(0xf6f6f6)
              ),
              child: ListView.builder(
                  scrollDirection:Axis.horizontal,
                  itemCount:colors.length,
                  itemBuilder: (context, index){
                    return
                      RaisedButton(
                        onPressed: (){
                          colorPress(index);
                        },
                        color: Color(0xf6f6f6),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              color: colors[index]
                          ),
                        ),
                      );
                  }
              ),
            ),
            Expanded(child:DrawView()),
          ],
        ),
      ),
    );
  }

  void colorPress(int index) {
    nowColor = colors[index];
    print("colorPress:$index");
  }
}

class DrawView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawViewState();
  }

}

class _DrawViewState extends State<DrawView>{

  LinePoints linePoints = new LinePoints();
  List<LinePoints> allLinePoints = [];

  void onDragStart(DragStartDetails detail){

    //一定要做转换，拿到坐标
    RenderBox box = context.findRenderObject();
    final Offset xy = box.globalToLocal(detail.globalPosition);// 重要需要转换以下坐标位置
    Offset point = Offset(xy.dx, xy.dy);

    if(linePoints.points == null){
      linePoints.points = new List();
    }else if(linePoints.points.length > 0){
      allLinePoints.add(
          new LinePoints(points: new List<Offset>.from(linePoints.points), lineColor: linePoints.lineColor),);
      linePoints.points.clear();
      //重新创建对象
      linePoints = new LinePoints();
      linePoints.points = new List();
      linePoints.lineColor = nowColor;
    }
    setState(() {
      linePoints.points.add(point);
    });
  }

  void onDragMove(DragUpdateDetails detail){
    //一定要做转换，拿到坐标
    RenderBox box = context.findRenderObject();
    final Offset xy = box.globalToLocal(detail.globalPosition);// 重要需要转换以下坐标位置
    Offset point = Offset(xy.dx, xy.dy);
    setState(() {
      linePoints.points.add(point);
    });
  }

  void ontabDown(TapDownDetails detail){
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GestureDetector(
        child: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: DrawViewPaint(allLinePoints,linePoints),
        ),
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragMove,
        onVerticalDragStart: onDragStart,
        onVerticalDragUpdate: onDragMove,
        onTapDown: ontabDown,
      ),
    );
  }

}

class DrawViewPaint extends CustomPainter{

  Paint painter = new Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 5.0
    ..filterQuality = FilterQuality.high
    ..style = PaintingStyle.stroke;

  List<LinePoints> allLinePoints;
  LinePoints linePoints;

  DrawViewPaint(this.allLinePoints, this.linePoints);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
//    canvas.save();
    print("allLinePoints:${allLinePoints.length}");
    for(int i = 0; i<allLinePoints.length; i++){
      LinePoints linePoints = allLinePoints[i];
      for(int j = 1; j<linePoints.points.length; j++){
        Offset p1 = linePoints.points[j - 1];
        Offset p2 = linePoints.points[j];
        painter.color = linePoints.lineColor;
        canvas.drawLine(p1, p2, painter);
      }
    }

    if(linePoints.points != null &&linePoints.points.length>0) {
      for (int j = 1; j < linePoints.points.length; j++) {
        Offset p1 = linePoints.points[j - 1];
        Offset p2 = linePoints.points[j];
        painter.color = linePoints.lineColor;
        canvas.drawLine(p1, p2, painter);
      }
      canvas.restore();
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}


class LinePoints{

  List<Offset> points;
  Color lineColor;
  LinePoints({this.points, this.lineColor = Colors.red});
}
