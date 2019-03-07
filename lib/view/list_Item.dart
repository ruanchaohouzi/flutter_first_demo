import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_demo/model/news.dart';
import 'package:flutter_first_demo/routers/routes.dart';

class ListItem extends StatefulWidget {
  NewsInfo newsInfo;

  ListItem(this.newsInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListItemState();
  }
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
//    return new Text(widget.newsInfo.title);

    return Padding(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            print(widget.newsInfo.url);
//            Navigator.pushNamed(context, "/NewsDetail");
            //携带参数跳转页面
//            Navigator.of(context).push(new PageRouteBuilder(
//                pageBuilder: (BuildContext context, _,  __) {
//                  return new NewsDetail(widget.newsInfo.url);
//                }));

            //参数必须经过Uri.encodeComponent处理
            Routes.router.navigateTo(context,
                '${Routes.newsDetails}?url=${Uri.encodeComponent(widget.newsInfo.url)}',
                transition: TransitionType.inFromRight,
                transitionDuration: Duration(milliseconds: 500)
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.newsInfo.title,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.newsInfo.authorName,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black26,
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(widget.newsInfo.category,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black26,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              getThumbnailImg(),
            ],
          ),
        ));
  }

  Widget getThumbnailImg(){

    if(widget.newsInfo.thumbnailPicS != null){
      return Image.network(widget.newsInfo.thumbnailPicS,fit: BoxFit.fitHeight,height: 70,);
    }else{
      return Text("");
    }
  }
}
