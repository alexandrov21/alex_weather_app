import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class ForecastDetails extends StatefulWidget {
  const ForecastDetails({Key? key}) : super(key: key);

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
      children: const [
        Expanded(
          child: Text(
            'London, United Kingdom',
          ),
        ),
        Icon(
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
            children: const [
              Text(
                '26.3°',
                style: TextStyles.detailsTemp,
              ),
              SizedBox(height: 8),
              Text('Sunny'),
              SizedBox(height: 8),
              Text('Chance of rain 0%'),
              SizedBox(height: 8),
              Text('Humidity 5%'),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 60,
          ),
          child: Icon(
            Icons.sunny,
            size: 100,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
