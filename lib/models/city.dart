import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  String? name;
  String? country;
  int? timezone;

  City(
    this.name,
    this.country,
    this.timezone,
  );

  City.empty()
      : name = '',
        country = '';

  factory City.fromJson(Map<String, dynamic> json) {
    return _$CityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
