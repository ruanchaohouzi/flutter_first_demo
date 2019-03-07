import 'package:json_annotation/json_annotation.dart'; 
  
part 'news.g.dart';


@JsonSerializable()
  class News extends Object {

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'result')
  NewsResult result;

  @JsonKey(name: 'error_code')
  int errorCode;

  News(this.reason,this.result,this.errorCode,);

  factory News.fromJson(Map<String, dynamic> srcJson) => _$NewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

}

  
@JsonSerializable()
  class NewsResult extends Object {

  @JsonKey(name: 'stat')
  String stat;

  @JsonKey(name: 'data')
  List<NewsInfo> newsInfoList;

  NewsResult(this.stat,this.newsInfoList,);

  factory NewsResult.fromJson(Map<String, dynamic> srcJson) => _$NewsResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsResultToJson(this);

}

  
@JsonSerializable()
  class NewsInfo extends Object {

  @JsonKey(name: 'uniquekey')
  String uniquekey;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'thumbnail_pic_s')
  String thumbnailPicS;

  NewsInfo({this.uniquekey,this.title,this.date,this.category,this.authorName,this.url,this.thumbnailPicS});

  factory NewsInfo.fromJson(Map<String, dynamic> srcJson) => _$NewsInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsInfoToJson(this);

}

  
