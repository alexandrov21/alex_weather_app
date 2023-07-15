import 'package:json_annotation/json_annotation.dart';
import 'city.dart';
import 'point_of_weather.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  City? city;
  List<PointOfWeather>? list;

  ForecastModel(
    this.city,
    this.list,
  );

  ForecastModel.empty()
      : city = City.empty(),
        list = [];

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return _$ForecastModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
