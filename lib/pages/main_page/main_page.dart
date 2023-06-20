import 'package:flutter/material.dart';
import 'package:task_3/models/forecast_model.dart';
import 'package:task_3/pages/main_page/views/forecast_details.dart';
import 'package:task_3/pages/main_page/views/forecast_info.dart';
import 'package:task_3/services/weather_api_client.dart';
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
  String _city = 'London';
  WeatherApiClient client = WeatherApiClient();
  ForecastModel? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather(_city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildBody();
          }
          return Container();
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.backgroundDay),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: _buildMainInfo(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildTopNavigationBar(),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          data?.city?.name ?? '',
          style: TextStyles.cityText,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "${data?.list?[0].main?.temp}°",
          style: TextStyles.mainTempText,
        ),
        ForecastInfo(
          isValueByDays: _isValueByDays,
          data: data,
        ),
        ForecastDetails(
          data: data,
        ),
      ],
    );
  }

  Widget _buildTopNavigationBar(){
    return Row(
      children: [
        Expanded(
          child: WeatherTextField(city: (city) {
            setState(() {
              _city = city;
            });
          }),
        ),
        WeatherDropDown(onDropDownChanged: (isValueByDays) {
          setState(() {
            _isValueByDays = isValueByDays;
          });
        }),
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
