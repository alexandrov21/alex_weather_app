import 'package:flutter/material.dart';

class ForecastModel {
  final String day;
  final IconData weather;
  final String temp;
  final String detail;
  final String hours;
  final IconData weatherByHours;
  final String tempByHours;
  final String detailByHours;

  ForecastModel(
    this.day,
    this.weather,
    this.temp,
    this.detail,
    this.hours,
    this.weatherByHours,
    this.tempByHours,
    this.detailByHours,
  );
}
