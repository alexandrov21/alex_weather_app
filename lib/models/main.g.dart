// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      (json['temp'] as num?)?.toDouble(),
      json['humidity'] as int?,
    )
      ..pressure = json['pressure'] as int?
      ..feels_like = (json['feels_like'] as num?)?.toDouble();

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'feels_like': instance.feels_like,
    };
