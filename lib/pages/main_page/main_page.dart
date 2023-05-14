import 'package:flutter/material.dart';
import 'package:task_3/pages/main_page/views/forecast_details.dart';
import 'package:task_3/pages/main_page/views/forecast_info.dart';
import 'package:task_3/views/weather_drop_down.dart';
import 'package:task_3/views/weather_text_field.dart';
import '../../utils/image_path.dart';
import '../../utils/text_styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isValueByDays = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(ImagePath.backgroundDay),
        fit: BoxFit.cover,
      )),
      child: SafeArea(
        top: false,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: _buildMainInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(child: WeatherTextField(city: (city) {})),
              WeatherDropDown(onDropDownChanged: (isValueByDays) {
                setState(() {
                  _isValueByDays = isValueByDays;
                });
              }),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          'London',
          style: TextStyles.cityText,
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          '26.3°',
          style: TextStyles.mainTempText,
        ),
        ForecastInfo(
          isValueByDays: _isValueByDays,
        ),
        const ForecastDetails(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
