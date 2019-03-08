import 'package:json_annotation/json_annotation.dart'; 
  
part 'weather.g.dart';


@JsonSerializable()
  class Weather extends Object {

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'error_code')
  int errorCode;

  Weather(this.reason,this.result,this.errorCode,);

  factory Weather.fromJson(Map<String, dynamic> srcJson) => _$WeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

}

  
@JsonSerializable()
  class Result extends Object {

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'realtime')
  NowWeather realtime;

  @JsonKey(name: 'future')
  List<FutureWeather> future;

  Result(this.city,this.realtime,this.future,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}

  
@JsonSerializable()
  class NowWeather extends Object {

  @JsonKey(name: 'temperature')
  String temperature;

  @JsonKey(name: 'humidity')
  String humidity;

  @JsonKey(name: 'info')
  String info;

  @JsonKey(name: 'wid')
  String wid;

  @JsonKey(name: 'direct')
  String direct;

  @JsonKey(name: 'power')
  String power;

  @JsonKey(name: 'aqi')
  String aqi;

  NowWeather(this.temperature,this.humidity,this.info,this.wid,this.direct,this.power,this.aqi,);

  factory NowWeather.fromJson(Map<String, dynamic> srcJson) => _$NowWeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NowWeatherToJson(this);

}

  
@JsonSerializable()
  class FutureWeather extends Object {

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'temperature')
  String temperature;

  @JsonKey(name: 'weather')
  String weather;

  @JsonKey(name: 'wid')
  Wid wid;

  @JsonKey(name: 'direct')
  String direct;

  FutureWeather(this.date,this.temperature,this.weather,this.wid,this.direct,);

  factory FutureWeather.fromJson(Map<String, dynamic> srcJson) => _$FutureWeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FutureWeatherToJson(this);

}

  
@JsonSerializable()
  class Wid extends Object {

  @JsonKey(name: 'day')
  String day;

  @JsonKey(name: 'night')
  String night;

  Wid(this.day,this.night,);

  factory Wid.fromJson(Map<String, dynamic> srcJson) => _$WidFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WidToJson(this);

}

  
