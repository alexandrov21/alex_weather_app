import 'package:flutter/material.dart';
import 'package:task_3/mocks/forecast_mock.dart';
import 'package:task_3/models/forecast_model.dart';
import 'package:task_3/utils/text_styles.dart';

import '../../../utils/app_colors.dart';

class ForecastInfo extends StatefulWidget {
  final bool isValueByDays;

  const ForecastInfo({
    Key? key,
    required this.isValueByDays,
  }) : super(key: key);

  @override
  State<ForecastInfo> createState() => _ForecastInfoState();
}

class _ForecastInfoState extends State<ForecastInfo> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 20,
        left: 16,
        right: 16,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          color: AppColors.forecastTile,
        ),
        child: _buildForecastInfo(),
      ),
    );
  }

  Widget _buildForecastInfo() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: _buildTileForecast(),
      ),
    );
  }

  Widget _buildTileForecast() {
    return Row(
      children: ForecastMock.forecast.map(
        (weather) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: widget.isValueByDays
                ? _buildWeatherByDays(weather)
                : _buildWeatherByHours(weather),
          );
        },
      ).toList(),
    );
  }

  Widget _buildWeatherByDays(ForecastModel weather) {
    return Column(
      children: [
        Text(weather.day),
        const SizedBox(height: 8),
        Icon(
          weather.weather,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          weather.temp,
          style: TextStyles.infoTemp,
        ),
        const SizedBox(height: 8),
        Text(
          weather.detail,
          style: TextStyles.infoDetail,
        ),
      ],
    );
  }

  Widget _buildWeatherByHours(ForecastModel weather) {
    return Column(
      children: [
        Text(weather.hours),
        const SizedBox(height: 8),
        Icon(
          weather.weatherByHours,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          weather.tempByHours,
          style: TextStyles.infoTemp,
        ),
        const SizedBox(height: 8),
        Text(
          weather.detailByHours,
          style: TextStyles.infoDetail,
        ),
      ],
    );
  }
}
