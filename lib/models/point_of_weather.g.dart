// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointOfWeather _$PointOfWeatherFromJson(Map<String, dynamic> json) =>
    PointOfWeather(
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      dt_txt: json['dt_txt'] as String?,
      dt: json['dt'] as int?,
    );

Map<String, dynamic> _$PointOfWeatherToJson(PointOfWeather instance) =>
    <String, dynamic>{
      'main': instance.main,
      'weather': instance.weather,
      'wind': instance.wind,
      'dt_txt': instance.dt_txt,
      'dt': instance.dt,
    };
