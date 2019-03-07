import 'package:dio/dio.dart';

class HttpUtil{

  Dio dio;

  //单列模式封装
  //通过私有的具名构造方法_internal()隐藏了构造方法，
  // 提供了一个工厂方法来获取该类的实例，
  // 并且用static final修饰了theOne，theOne会在编译期被初始化，保证了特征3

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil(){
    return _instance;
  }

  HttpUtil._internal(){
    if(dio == null){
      dio = new Dio(Options(
//        baseUrl: "http://www.wanandroid.com",
        receiveTimeout: 10 * 1000,
        connectTimeout: 60 * 1000,
      ));

      //添加拦截器
      addIntercept();
      //增加抓包代理
      //addProxy();
    }
  }

  void addIntercept() {
    //请求之前拦截器
    dio.interceptor.request.onSend = (Options options){
      //打印请求日志
      print("request data:${options.data},request path：${options.path}");
      return options;
    };

    //请求成功拦截器
    dio.interceptor.response.onSuccess = (Response response){
      print("response info：${response.data.toString()}",);
      return response;
    };

    //请求失败拦截器
    dio.interceptor.response.onError = (DioError err){
      print("request error：${err.message}",);
      return err;
    };

  }

  /**
   * get请求
   */
  Future<Map<String, dynamic>> get(String path, [dynamic params]) async {
    Response<Map<String, dynamic>> response;
    if (null != params) {
      response = await dio.get(path, data: params);
    } else {
      response = await dio.get(path);
    }
    return response.data;
  }

  /**
   * post请求
   */
  Future<Map<String, dynamic>> post(String path, [dynamic params]) async {
    Response<Map<String, dynamic>> response;
    if (null != params) {
      response = await dio.post(path, data: params);
    } else {
      response = await dio.post(path);
    }
    return response.data;
  }

  /**
   * 文件下载
   */
  Future<Map<String, dynamic>> down(String path,String savePath, [Map<String, dynamic> params]) async {
    Response<Map<String, dynamic>> response;
    if (null != params) {
      response = await dio.download(path, savePath,data: params);
    } else {
      response = await dio.download(path, savePath);
    }
    return response.data;
  }

  void addProxy() {
    //并且由于flutter原生的网络库http不支持charles抓包，这个库可以使用设置代理来达到抓包的目的，ip自己替换
//      dio.onHttpClientCreate = (HttpClient client) {
//        client.findProxy = (uri) {
//          //proxy all request to localhost:8888
//          return "PROXY yourIP:yourPort";
//        };
//      };
  }
}