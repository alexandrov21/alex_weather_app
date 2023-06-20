import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        top: 32,
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
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5.7,
      child: ListView.builder(
        itemCount: widget.isValueByDays ? 5 : 9,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (widget.isValueByDays) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildWeatherByDays(index),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildWeatherByDays(index * 8),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildWeatherByHours(index),
          );
        },
      ),
    );
  }

  Widget _buildWeatherByDays(index) {
    final dateResult = widget.data?.list?[index].dt_txt?.split(' ');
    String formatterDate = DateFormat.E().format(
      DateTime.parse(dateResult?[0] ?? ''),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatterDate,
          style: TextStyles.formattedDateText,
        ),
        const SizedBox(height: 4),
        Image.network(
          'http://openweathermap.org/img/wn/${widget.data?.list?[index].weather?.first.icon}.png',
        ),
        const SizedBox(height: 4),
        Text(
          widget.data?.list?[index].main?.temp.toString() ?? '',
          style: TextStyles.infoTemp,
        ),
        const SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.data?.list?[index].main?.pressure}',
              style: TextStyles.infoDetail,
            ),
            const Text(
              'pressure',
              style: TextStyles.infoDetail,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherByHours(index) {
    final timeResult = widget.data?.list?[index].dt_txt?.split(' ');
    final shortTimeResult = timeResult?[1].split(':');
    final formattedTime = shortTimeResult?[0];
    // String? formattedTime = DateFormat.Hm().format(
    //   DateTime.parse(timeResult?[1] ?? ''),
    // );
    return Column(
      children: [
        Text(
          formattedTime ?? '',
          style: TextStyles.formattedTimeText,
        ),
        Image.network(
          'http://openweathermap.org/img/wn/${widget.data?.list?[index].weather?.first.icon}.png',
        ),
        const SizedBox(height: 4),
        Text(
          widget.data?.list?[index].main?.temp.toString() ?? '',
          style: TextStyles.infoTemp,
        ),
        const SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.data?.list?[index].main?.pressure}',
              style: TextStyles.infoDetail,
            ),
            const Text(
              'pressure',
              style: TextStyles.infoDetail,
            )
          ],
        ),
      ],
    );
  }
}
