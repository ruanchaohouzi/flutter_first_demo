import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_first_demo/view/user_view.dart';

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() => new SecondPageState();
}

class SecondPageState extends State<SecondPage> {

  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          new UserView(),
          Text("text"),
          VerificationCodeInput(
            textSize: 50.0,
            letterSpace: 30.0,
            inputBorder: CustomRectInputBorder(
                letterSpace: 30.0,
                textSize: 50.0,
                textLength: 4,
                borderSide: BorderSide(color: Colors.black26, width: 2.0)),
          ),
          CustomPaint(
            painter: new ScrawPainter(pointValues:points),
            child: Container(
              width: 300.0,
              height: 300.0,
              color: Colors.blue,
              child: GestureDetector(
                onPanUpdate: (details) {
                  RenderBox referenceBox = context.findRenderObject();
                  Offset localPosition =
                      referenceBox.globalToLocal(details.globalPosition);
                  setState(() {
                    points.add(localPosition);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrawPainter extends CustomPainter {
  List<Offset> pointValues = [];

  ScrawPainter({this.pointValues});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round //线条结束时的绘制样式
      ..strokeWidth = 4.0 //线条宽度
      ..style = PaintingStyle.stroke; //绘制模式，画线 or 充满

    for (int i = 0; i < pointValues.length - 1; i++) {
      if (pointValues[i] != null && pointValues[i + 1] != null)
        canvas.drawLine(pointValues[i], pointValues[i + 1], paint);
    }
    print("end");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class VerificationCodeInput extends StatefulWidget {
  final double letterSpace;
  final double textSize;
  final int codeLength;
  final InputBorder inputBorder;

  VerificationCodeInput({
    Key key,
    this.letterSpace = 20.0,
    this.textSize = 20.0,
    this.codeLength = 4,
    this.inputBorder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerificationCodeInputState();
}

class VerificationCodeInputState extends State<VerificationCodeInput> {
  double textTrueWidth;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (str) {
        if (str.length == widget.codeLength) {}
      },
      maxLength: widget.codeLength,
      keyboardType: TextInputType.number,
      style: TextStyle(
          fontSize: widget.textSize,
          color: Colors.black87,
          letterSpacing: widget.letterSpace),
      decoration: InputDecoration(
          hintText: '    Please input verification code',
          hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.0),
          enabledBorder: widget.inputBorder,
          focusedBorder: widget.inputBorder),
    );
  }
}

abstract class InputBorder extends UnderlineInputBorder {
  double textSize;
  double letterSpace;
  int textLength;

  double textTrueWidth;
  final double startOffset;

  void calcTrueTextSize() {
    // 测量单个数字实际长度
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: textSize))
      ..addText("0");
    var p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    textTrueWidth = p.minIntrinsicWidth;
  }

  InputBorder({
    this.textSize = 0.0,
    this.letterSpace = 0.0,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  })  : startOffset = letterSpace * 0.5,
        super(borderSide: borderSide) {
    calcTrueTextSize();
  }
}

class CustomRectInputBorder extends InputBorder {
  CustomRectInputBorder({
    double textSize = 0.0,
    double letterSpace,
    int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  double get offsetX => textTrueWidth * 0.3;

  double get offsetY => textTrueWidth * 0.3;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double curStartX = rect.left; //+ startOffset - offsetX;
    for (int i = 0; i < textLength; i++) {
      Rect r = Rect.fromLTWH(curStartX, rect.top + offsetY,
          textTrueWidth + offsetX * 2, rect.height - offsetY * 2);
      canvas.drawRect(r, borderSide.toPaint());
      curStartX += (textTrueWidth + letterSpace);
    }
  }
}
