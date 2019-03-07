import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first_demo/model/news.dart';
import 'dart:math';

import 'package:flutter_first_demo/routers/routes.dart';
import 'package:rxdart/rxdart.dart';

class NewsBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsBannerState();
  }
}

class _NewsBannerState extends State<NewsBanner> {
  PageController _pageController;
  int realIndex = 1;
  Timer timer;
  List<NewsInfo> titleNewsInfos = [];
  List<Widget> banners = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(
      initialPage: realIndex,
    );
    //初始化banners数据
    initTitleNewsInfo();
    //初始化banner
    getPages();
    //定时器定时滚动
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int page = 0;
      if (realIndex == banners.length - 1) {
        _pageController.jumpTo(0);
        page = 1;
      } else {
        page = realIndex + 1;
      }
      print("page :" + page.toString());
      _pageController.animateToPage(page,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });

    //rxDart实现
//    var perObservable = Observable.periodic(Duration(seconds: 5), (times) {
//      return times;
//    });
//    perObservable.listen((t) {
//      int page = 0;
//      if (realIndex == banners.length - 1) {
//        _pageController.jumpTo(0);
//        page = 1;
//      } else {
//        page = realIndex + 1;
//      }
//      print("page :" + page.toString());
//      _pageController.animateToPage(page,
//          duration: Duration(milliseconds: 400), curve: Curves.linear);
//    },
//    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: banners,
              ),
              getIndicator(),
            ],
          )),
    );
  }

  void _onPageChanged(int index) {
    realIndex = index;

    setState(() {});
  }

  List<Widget> getPages() {
    //首尾相连，所以先把最后一页加上去
    banners.add(pageWidget(titleNewsInfos.length - 1));
    for (int i = 0; i < titleNewsInfos.length; i++) {
      banners.add(pageWidget(i));
    }
    return banners;
  }

  Container pageWidget(int i) {
    return new Container(
        child: GestureDetector(
          onTap: _onPageClick,
          child: Stack(
            children: <Widget>[
              Image.network(
                titleNewsInfos[i].thumbnailPicS,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Text(
                      titleNewsInfos[i].title,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
            ],
          ),
        ));
  }

  void _onPageClick() {
    Routes.router.navigateTo(context, "${Routes.newsDetails}?url=${Uri.encodeComponent(titleNewsInfos[realIndex - 1].url)}");
  }

  Widget getIndicator() {
    List<Widget> list = [];

    for (int i = 0; i < titleNewsInfos.length; i++) {
      var bgColor;
      if (realIndex - 1 == i
          || (realIndex == 0 && (i == (titleNewsInfos.length - 1)))) {
        bgColor = Colors.red;
      } else {
        bgColor = Colors.white;
      }
      var coin = Container(
          margin: EdgeInsets.all(10.0),
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor),
          ));
      list.add(coin);
    }
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  void initTitleNewsInfo() {
    NewsInfo newsInfo = new NewsInfo();
    newsInfo.thumbnailPicS =
        "https://imgsa.baidu.com/news/q%3D100/sign=dada93fca151f3dec5b2bd64a4eff0ec/3ac79f3df8dcd100fd6da3177c8b4710b9122f16.jpg";
    newsInfo.title = "习近平会见探月工程嫦娥四号任务参研参试人员代表";
    newsInfo.url =
        "http://www.xinhuanet.com/politics/leaders/2019-02/20/c_1124142195.htm";
    titleNewsInfos.add(newsInfo);
    NewsInfo newsInfo1 = new NewsInfo();
    newsInfo1.thumbnailPicS =
        "https://imgsa.baidu.com/news/q%3D100/sign=0f82cbc4731ed21b7fc92ae59d6eddae/8b82b9014a90f603fb9bc6713712b31bb051edd9.jpg";
    newsInfo1.title = "习近平会见伊朗伊斯兰议会议长拉里贾尼";
    newsInfo1.url =
        "http://www.xinhuanet.com/politics/leaders/2019-02/20/c_1124142381.htm";
    titleNewsInfos.add(newsInfo1);

    NewsInfo newsInfo2 = new NewsInfo();
    newsInfo2.thumbnailPicS =
        "https://imgsa.baidu.com/news/q%3D100/sign=e779f828b7389b503effe452b534e5f1/fc1f4134970a304ef4b742ccdfc8a786c9175c6b.jpg";
    newsInfo2.title = "全国铁路迎来新一轮客流高峰";
    newsInfo2.url =
        "http://picture.youth.cn/qtdb/201902/t20190221_11875288.htm";
    titleNewsInfos.add(newsInfo2);

    NewsInfo newsInfo3 = new NewsInfo();
    newsInfo3.thumbnailPicS =
        "https://imgsa.baidu.com/news/q%3D100/sign=90de5342e5f81a4c2032e8c9e72b6029/00e93901213fb80ee70180e138d12f2eb9389430.jpg";
    newsInfo3.title = "500架无人机“笔芯”南京 青奥艺术灯会再刷屏";
    newsInfo3.url =
        "http://photo.cctv.com/2019/02/21/PHOAFz4mYfH7A4a60pswbOXx190221.shtml?spm=C94212.PV1fmvPpJkJY.S71844.161#qEwTX7ONKPFy190221_1";
    titleNewsInfos.add(newsInfo3);
  }
}
