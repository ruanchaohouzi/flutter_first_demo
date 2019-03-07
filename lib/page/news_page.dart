import 'dart:async';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_demo/model/news.dart';
import 'package:flutter_first_demo/page/news_banner.dart';
import 'package:flutter_first_demo/utils/http_util.dart';
import 'package:flutter_first_demo/view/list_Item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewsPage extends StatefulWidget {
  @override
  NewsPageState createState() => new NewsPageState();
}

class NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin{

  ScrollController _scrollController = new ScrollController();
  bool _hasMore = true;
  bool isLoading = false;
  String emptContent = '数据加载中，请稍后...';
  NewsResult newsResult;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData(requestType: RequestType.direct);
    _scrollController.addListener((){
      var maxScrollExtent = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if(pixels == maxScrollExtent){
        print("load more");
        getNewsData(requestType: RequestType.dropDown);
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("头条新闻")),
      body: getWidget(),
    );
  }

  Widget getWidget(){

    if(newsResult == null){
      return Center(
          child: Text("$emptContent", style: TextStyle(
              color: Colors.red,
              fontSize: 32.0
          ),),
        );
    }else{
      Widget listView = new ListView.builder(
        itemCount: newsResult.newsInfoList.length * 2 + 2,//+1是为了加上最后的,以及banner信息  加载更多的widget
        itemBuilder: (context, index) {

          //显示banner
          if(index == 0){
            return NewsBanner();
          }
          //不显示banner下下面的横线
          else if(index == 1){
            return Container(height: 1.0,);
          }
          //滑到最低端
          else if(index > 0 && index == newsResult.newsInfoList.length * 2){
            isLoading = true;
            return _buildLoadMoreWidget();
          } else if(index.isOdd){//基数行
            return new Divider(
              height: 1.0,
            );
          }else{
            return new ListItem(newsResult.newsInfoList[(index-1) ~/ 2]);
          }
        },
        controller:_scrollController,
      );
      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  Future<Null> getNewsData({RequestType requestType = RequestType.direct}) async {

    String appKey = "28382efd8a069ac39646fbdbf2212aea" + "sss";
    //聚合数据接口
    String url = "http://v.juhe.cn/toutiao/index?type=top&key=$appKey";
    var response = await HttpUtil().get(url, null);
    print(response);
    News news;
    if(response == null || (news = News.fromJson(response)).errorCode != 0){
      setState(() {
        if(requestType == RequestType.direct){
          emptContent = "数据加载失败";
        }
        Fluttertoast.showToast(msg: "数据加载失败，错误码${response['error_code']}", timeInSecForIos: 2);
        isLoading = false;
      });
      return null;
    }
    setState(() {
      if(requestType == RequestType.pullUp){
        newsResult = news.result;
      }else if(requestType == RequestType.dropDown){
        isLoading = false;
        newsResult.newsInfoList.addAll(news.result.newsInfoList);
      } else {
        newsResult = news.result;
      }
    });
    return null;
  }

  Future<Null> _pullToRefresh() {
    return getNewsData(requestType: RequestType.pullUp);
  }

  Widget _buildLoadMoreWidget() {

    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
              children: <Widget>[
                new Opacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  child: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 20.0),
                Text(
                  "数据加载中",
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            )
          //child:
        ),
      );
    } else {
      return Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text("没有更多新闻了！！！"),
            ),
          ));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

enum RequestType{
  direct,
  pullUp,
  dropDown

}