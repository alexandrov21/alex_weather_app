import 'package:flutter/material.dart';

import '../../../models/forecast_model.dart';
import '../../../utils/text_styles.dart';

class ForecastDetails extends StatefulWidget {
  final ForecastModel? data;

  const ForecastDetails({Key? key, required this.data}) : super(key: key);

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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
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
    return Row(
      children: [
        Expanded(
          child: Text(
            '${widget.data?.city?.name}, ${widget.data?.city?.country}',
            style: TextStyles.cityDetailsText,
          ),
        ),
        const Icon(
          Icons.more_horiz_outlined,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildForecastDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 52,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.data?.list?[0].main?.temp}°",
                style: TextStyles.detailsTemp,
              ),
              const SizedBox(height: 8),
              Text(widget.data?.list?[0].weather?[0].main ?? ''),
              const SizedBox(height: 8),
              Text('Speed of wind ${widget.data?.list?[0].wind?.speed} km/h'),
              const SizedBox(height: 8),
              Text('Humidity ${widget.data?.list?[0].main?.humidity} %'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 48,
            bottom: 40,
          ),
          child: Image.network(
            'http://openweathermap.org/img/wn/${widget.data?.list?[0].weather?[0].icon}.png',
            scale: 0.6,
          ),
        ),
      ],
    );
  }
}
