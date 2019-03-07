import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserView extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_UserViewState();

}

class _UserViewState extends State<UserView>{
  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 200.0,
      width: 200.0,
      color: Colors.red,
      padding: EdgeInsets.all(10.0),
      child: CustomPaint(
        painter: MyPainter(),
      ),
    );
  }

}

class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round //线条结束时的绘制样式
      ..strokeWidth = 4.0//线条宽度
      ..style = PaintingStyle.stroke;//绘制模式，画线 or 充满

    canvas.drawArc(Offset.zero&size, 0, math.pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}