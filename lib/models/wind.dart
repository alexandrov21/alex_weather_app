import 'package:json_annotation/json_annotation.dart';

part 'wind.g.dart';

@JsonSerializable()
class Wind{
  double? speed;
  Wind(this.speed);
  factory Wind.fromJson(Map<String, dynamic> json) {
    return _$WindFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WindToJson(this);
}