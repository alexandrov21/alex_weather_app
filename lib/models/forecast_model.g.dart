// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      (json['list'] as List<dynamic>?)
          ?.map((e) => PointOfWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'list': instance.list,
    };
