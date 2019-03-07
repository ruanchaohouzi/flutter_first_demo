// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      json['reason'] as String,
      json['result'] == null
          ? null
          : NewsResult.fromJson(json['result'] as Map<String, dynamic>),
      json['error_code'] as int);
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'reason': instance.reason,
      'result': instance.result,
      'error_code': instance.errorCode
    };

NewsResult _$NewsResultFromJson(Map<String, dynamic> json) {
  return NewsResult(
      json['stat'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : NewsInfo.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NewsResultToJson(NewsResult instance) =>
    <String, dynamic>{'stat': instance.stat, 'data': instance.newsInfoList};

NewsInfo _$NewsInfoFromJson(Map<String, dynamic> json) {
  return NewsInfo(
      uniquekey: json['uniquekey'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
      authorName: json['author_name'] as String,
      url: json['url'] as String,
      thumbnailPicS: json['thumbnail_pic_s'] as String);
}

Map<String, dynamic> _$NewsInfoToJson(NewsInfo instance) => <String, dynamic>{
      'uniquekey': instance.uniquekey,
      'title': instance.title,
      'date': instance.date,
      'category': instance.category,
      'author_name': instance.authorName,
      'url': instance.url,
      'thumbnail_pic_s': instance.thumbnailPicS
    };
