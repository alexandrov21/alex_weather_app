import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@JsonSerializable()
class Main {
  double? temp;
  int? humidity;

  Main(
    this.temp,
    this.humidity,
  );

  factory Main.fromJson(Map<String, dynamic> json) {
    return _$MainFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainToJson(this);
}
