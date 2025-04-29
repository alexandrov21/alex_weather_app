  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:task_3/models/forecast_model.dart';
  import 'package:task_3/utils/app_strings.dart';
  import '../../../utils/light_app_colors.dart';
  import '../../../utils/themes.dart';

  class ForecastInfo extends StatefulWidget {
    final bool isValueByDays;
    final ForecastModel data;

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
      return Padding(
        padding: const EdgeInsets.only(
          top: 32,
          bottom: 20,
          left: 16,
          right: 16,
        ),
        child: _buildBody(),
      );
    }

    Widget _buildBody() {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          color: LightAppColors.forecastTile,
        ),
        child: _buildForecastInfo(),
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
      final forecastInfoTileSize = MediaQuery.of(context).size.height / 5.7;
      return SizedBox(
        height: forecastInfoTileSize,
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
      final dateResult = widget.data.list?[index].dt_txt?.split(' ');
      String formatterDate = DateFormat.E().format(
        DateTime.parse(dateResult?.first ?? ''),
      );
      final weatherIcon = widget.data.list?[index].weather;
      final temp = widget.data.list?[index].main?.temp.toString() ?? '';
      final pressure = widget.data.list?[index].main?.pressure;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatterDate,
            style: Themes.formattedDateText,
          ),
          const SizedBox(height: 4),
          weatherIcon != null
              ? Image.network(
                  'http://openweathermap.org/img/wn/${weatherIcon.first.icon}.png',
                )
              : const SizedBox(
                  height: 24,
                  width: 24,
                  child: Placeholder(),
                ),
          const SizedBox(height: 4),
          Text(
            temp,
            style: Themes.infoTemp,
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$pressure',
                style: Themes.infoDetail,
              ),
              Text(
                AppStrings.pressure,
                style: Themes.infoDetail,
              )
            ],
          ),
        ],
      );
    }

    Widget _buildWeatherByHours(index) {
      final timeResult = widget.data.list?[index].dt_txt?.split(' ');
      final shortTimeResult = timeResult?[1].split(':');
      final formattedTime = shortTimeResult?.first;

      final weatherIcon = widget.data.list?[index].weather;
      final temp = widget.data.list?[index].main?.temp.toString() ?? '';
      final pressure = widget.data.list?[index].main?.pressure;

      return Column(
        children: [
          Text(
            formattedTime ?? '',
            style: Themes.formattedTimeText,
          ),
          weatherIcon != null
              ? Image.network(
                  'http://openweathermap.org/img/wn/${weatherIcon.first.icon}.png',
                )
              : const SizedBox(
                  width: 24,
                  height: 24,
                  child: Placeholder(),
                ),
          const SizedBox(height: 4),
          Text(
            temp,
            style: Themes.infoTemp,
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$pressure',
                style: Themes.infoDetail,
              ),
              Text(
                AppStrings.pressure,
                style: Themes.infoDetail,
              )
            ],
          ),
        ],
      );
    }
  }
