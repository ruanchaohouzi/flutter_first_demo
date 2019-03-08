// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      json['reason'] as String,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      json['error_code'] as int);
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'reason': instance.reason,
      'result': instance.result,
      'error_code': instance.errorCode
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['city'] as String,
      json['realtime'] == null
          ? null
          : NowWeather.fromJson(json['realtime'] as Map<String, dynamic>),
      (json['future'] as List)
          ?.map((e) => e == null
              ? null
              : FutureWeather.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'city': instance.city,
      'realtime': instance.realtime,
      'future': instance.future
    };

NowWeather _$NowWeatherFromJson(Map<String, dynamic> json) {
  return NowWeather(
      json['temperature'] as String,
      json['humidity'] as String,
      json['info'] as String,
      json['wid'] as String,
      json['direct'] as String,
      json['power'] as String,
      json['aqi'] as String);
}

Map<String, dynamic> _$NowWeatherToJson(NowWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'info': instance.info,
      'wid': instance.wid,
      'direct': instance.direct,
      'power': instance.power,
      'aqi': instance.aqi
    };

FutureWeather _$FutureWeatherFromJson(Map<String, dynamic> json) {
  return FutureWeather(
      json['date'] as String,
      json['temperature'] as String,
      json['weather'] as String,
      json['wid'] == null
          ? null
          : Wid.fromJson(json['wid'] as Map<String, dynamic>),
      json['direct'] as String);
}

Map<String, dynamic> _$FutureWeatherToJson(FutureWeather instance) =>
    <String, dynamic>{
      'date': instance.date,
      'temperature': instance.temperature,
      'weather': instance.weather,
      'wid': instance.wid,
      'direct': instance.direct
    };

Wid _$WidFromJson(Map<String, dynamic> json) {
  return Wid(json['day'] as String, json['night'] as String);
}

Map<String, dynamic> _$WidToJson(Wid instance) =>
    <String, dynamic>{'day': instance.day, 'night': instance.night};
