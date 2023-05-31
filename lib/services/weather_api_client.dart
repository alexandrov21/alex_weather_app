import 'dart:convert';

import '../models/forecast_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<ForecastModel>? getCurrentWeather(String? location) async {
    final endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=8a071f344bb4ece65443d46fed81244c&units=metric");
    final response = await http.get(endpoint);
    final body = jsonDecode(response.body);
    return ForecastModel.fromJson(body);
  }
}
