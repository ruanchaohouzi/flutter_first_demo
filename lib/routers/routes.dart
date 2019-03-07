
import 'package:fluro/fluro.dart';
import 'package:flutter_first_demo/test/news_detail.dart';
import 'package:flutter_first_demo/test/test_page.dart';

class Routes{

  static String newsDetails = "/news-detail";
  static String testPage = "/test";
  static Router router;

  static configureRoutes(Router router){
    router.define(testPage, handler: Handler(
      handlerFunc: (context,param){
        return TestPage();
      }
    ));
    router.define(newsDetails, handler: Handler(
      handlerFunc: (context,parameters){
        String url = parameters['url']?.first;
        return new NewsDetail(url);
      }
    ));
    Routes.router = router;
  }
}
