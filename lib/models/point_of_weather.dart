import 'package:json_annotation/json_annotation.dart';

import 'main.dart';
import 'weather.dart';
import 'wind.dart';
part 'point_of_weather.g.dart';
@JsonSerializable()
class PointOfWeather {
  Main? main;
  List<Weather>? weather;
  Wind? wind;
  String? dt_txt;
  int? dt;

  PointOfWeather({
    this.main,
    this.weather,
    this.wind,
    this.dt_txt,
    this.dt,
  });

  factory PointOfWeather.fromJson(Map<String, dynamic> json) {
    return _$PointOfWeatherFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PointOfWeatherToJson(this);
}