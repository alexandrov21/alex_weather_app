import 'package:flutter/material.dart';
import 'package:task_3/mocks/forecast_mock.dart';
import 'package:task_3/models/forecast_model.dart';
import 'package:task_3/utils/text_styles.dart';

import '../../../utils/app_colors.dart';

class ForecastInfo extends StatefulWidget {
  final bool isValueByDays;
  final ForecastModel? data;

  const ForecastInfo({
    Key? key,
    required this.isValueByDays,
    required this.data,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      child: _buildTileForecast(),
    );
  }

  Widget _buildTileForecast() {
    print(widget.data?.list?.length);
    return Expanded(
      child: ListView.builder(
        itemCount: widget.data?.list?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return widget.isValueByDays
              ? _buildWeatherByDays(index)
              : _buildWeatherByHours();
        },
      ),
    );
  }

  Widget _buildWeatherByDays(index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(weather.day),
        const SizedBox(height: 8),
        Image.network(
          'http://openweathermap.org/img/wn/${widget.data?.list?[index].weather?[index].icon}.png',
        ),
        const SizedBox(height: 8),
        Text(
          widget.data?.list?[index].main?.temp.toString() ?? '',
          style: TextStyles.infoTemp,
        ),
        const SizedBox(height: 8),
        Text(
          widget.data?.list?[index].main?.humidity.toString() ?? '',
          style: TextStyles.infoDetail,
        ),
      ],
    );
  }

  Widget _buildWeatherByHours() {
    return Container();
    //   Column(
    //   children: [
    //     Text(weather.hours),
    //     const SizedBox(height: 8),
    //     Icon(
    //       weather.weatherByHours,
    //       color: Colors.white,
    //       size: 32,
    //     ),
    //     const SizedBox(height: 8),
    //     Text(
    //       weather.tempByHours,
    //       style: TextStyles.infoTemp,
    //     ),
    //     const SizedBox(height: 8),
    //     Text(
    //       weather.detailByHours,
    //       style: TextStyles.infoDetail,
    //     ),
    //   ],
    // );
  }
}
