import 'package:flutter/material.dart';

class Visibility extends StatelessWidget{

   final Widget child;
   final Widget removeChild;
   final VisibilityFlag visibility;

  Visibility({@required this.child, @required this.visibility}):removeChild = Container();


  @override
  Widget build(BuildContext context) {
    if(visibility == VisibilityFlag.visible){
      return child;
    }else if(visibility == VisibilityFlag.invisible){
      return IgnorePointer(
        ignoring: true,
        child: Opacity(opacity: 0.0, child: child,
        ),
      );
    }else if(visibility == VisibilityFlag.offscreen){
      return Offstage(offstage: true, child: child,);
    }else{
      return removeChild;
    }
  }
}

enum VisibilityFlag{
  visible,
  invisible,
  offscreen,
  gone,
}