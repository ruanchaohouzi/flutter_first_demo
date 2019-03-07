import 'package:flutter/material.dart';

class UserPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserPageState();
  }

}

class UserPageState extends State<UserPage>{

  String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
        Future.delayed(Duration(milliseconds: 300),(){
          if(userName == null) {
            showLoginDialog(context);
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
      ),
      body: getBodyWidget(context),
    );
  }

  getBodyWidget(BuildContext context){
    return Container(
        child: Column(
          children: <Widget>[
            Text("个人中心"),
            RaisedButton(
              onPressed: () {
                showLoginDialog(context);
              },
              child: Text("弹框"),
            ),
          ],
        )
    );
  }

  showLoginDialog(BuildContext context) {
    showDialog(context: context,
        builder: (context) {
           return AlertDialog(
            content: Text("请还没有登录，请先登录"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {

                },
                child: Text("登录"),
              ),
              FlatButton(
                onPressed: () {

                  Navigator.of(context).pop(true);
                },
                child: Text("取消"),
              ),
            ],
          );
        }
    );
  }

}