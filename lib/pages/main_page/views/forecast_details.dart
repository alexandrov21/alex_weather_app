import 'package:flutter/material.dart';
import 'package:task_3/utils/app_strings.dart';
import '../../../models/forecast_model.dart';
import '../../../utils/themes.dart';

class ForecastDetails extends StatefulWidget {
  final ForecastModel? data;

  const ForecastDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ForecastDetails> createState() => _ForecastDetailsState();
}

class _ForecastDetailsState extends State<ForecastDetails> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          color: Colors.black26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              child: _buildCityDetails(),
            ),
            _buildForecastDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDetails() {
    final cityName = widget.data?.city?.name;
    final countryName = widget.data?.city?.country;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$cityName, $countryName',
            style: Themes.cityDetailsText,
          ),
        ),
        Icon(
          Icons.more_horiz_outlined,
          color: Themes.moreIcon,
        ),
      ],
    );
  }

  Widget _buildForecastDetails() {
    final weatherIcon = widget.data?.list?.first.weather;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 44, 20, 20),
          child: _buildDetailsCharacteristics(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 48,
            bottom: 40,
          ),
          child: weatherIcon != null
              ? Image.network(
                  'http://openweathermap.org/img/wn/${weatherIcon.first.icon}.png',
                  scale: 0.6,
                )
              : const SizedBox(
                  height: 24,
                  width: 24,
                  child: Placeholder(),
                ),
        ),
      ],
    );
  }

  Widget _buildDetailsCharacteristics() {
    final feelsLikeTemp = widget.data?.list?.first.main?.feels_like;
    final weatherDetails = widget.data?.list?.first.weather?.first.main ?? '';
    final speedOfWind = widget.data?.list?.first.wind?.speed;
    final humidity = widget.data?.list?.first.main?.humidity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.feelsLike,
          style: Themes.feelsLikeText,
        ),
        Text(
          "$feelsLikeTemp°",
          style: Themes.detailsTemp,
        ),
        const SizedBox(height: 8),
        Text(
          weatherDetails,
          style: Themes.detailsWeatherText,
        ),
        const SizedBox(height: 8),
        Text(
          '${AppStrings.speedOfWind} $speedOfWind ${AppStrings.kmH}',
          style: Themes.detailsWindText,
        ),
        const SizedBox(height: 8),
        Text(
          '${AppStrings.humidity} $humidity %',
          style: Themes.detailsHumidityText,
        ),
      ],
    );
  }
}
