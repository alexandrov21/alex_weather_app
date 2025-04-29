import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_3/models/forecast_model.dart';
import 'package:task_3/pages/main_page/views/favorites_page.dart';
import 'package:task_3/pages/main_page/views/forecast_details.dart';
import 'package:task_3/pages/main_page/views/forecast_info.dart';
import 'package:task_3/services/weather_api_client.dart';
import 'package:task_3/utils/app_strings.dart';
import 'package:task_3/views/weather_drop_down.dart';
import 'package:task_3/views/weather_text_field.dart';
import '../../utils/image_path.dart';
import '../../utils/themes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:country_codes/country_codes.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isValueByDays = true;
  String _city = AppStrings.defaultCity;
  final WeatherApiClient _client = WeatherApiClient();
  late ForecastModel _data;
  bool isFavorite = false;
  UniqueKey favoriteKey = UniqueKey();

  final user = FirebaseAuth.instance.currentUser;

  Future<void> _getData() async {
    _data = await _client.getCurrentWeather(_city) ?? ForecastModel.empty();
    print(_data);
  }

  Future<void> _checkIfFavorite() async {
    print(user?.uid);
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('favorites')
        .doc(_city);
    final docSnapshot = await doc.get();
    //setState(() => isFavorite = docSnapshot.exists);
    isFavorite = docSnapshot.exists;
    favoriteKey = UniqueKey();
    print(doc);
  }

  Future<void> toggleFavoriteCity() async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('favorites')
        .doc(_city);

    final docSnapshot = await doc.get();
    if (docSnapshot.exists) {
      await doc.delete();
      setState(() => isFavorite = false);
    } else {
      await doc.set({'city': _city});
      setState(() => isFavorite = true);
    }
  }

  Future<void> _getAllData() async {
    try{await _getData();
    await _checkIfFavorite();
    }
    catch(e){print(e);}

    return;
  }
  Locale getLocaleFromCountryCode(String countryCode, {String defaultLanguage = 'en'}) {
    return Locale(defaultLanguage, countryCode.toUpperCase());
  }

  String _getBackground() {
    //final timeresult = _data.list.first.
    final timeResult = _data.list?.first.dt_txt?.split(' ');
    if (timeResult == null || timeResult.length < 2) {
      Themes.isLight = true;
      return ImagePath.backgroundDay;
    }
    final shortTimeResult = timeResult[1].split(':');
    final formattedTime = shortTimeResult.first;
    final hour = int.parse(formattedTime);

    // final country = CountryCodes.detailsForLocale((getLocaleFromCountryCode(_data.city?.country?? 'GB')));
    // final location = tz.getLocation('${country.name}/${_data.city?.name??AppStrings.defaultCity}'); // укажи нужный город
    // final now = tz.TZDateTime.now(location);
    // final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    // print (hour);
    // print('+');
    // print(_data.city?.name);
    // print(formattedTime);
    // print(shortTimeResult);
    if (hour >= 06 && hour <= 15) {
      Themes.isLight = true;
      return ImagePath.backgroundDay;
    }
    Themes.isLight = false;
    return ImagePath.backgroundNight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildBody();
          }
          print(snapshot.connectionState);
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    final cityName = _data.city?.name ?? '';
    final temp = _data.list?[0].main?.temp;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_getBackground()),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: _buildMainInfo(cityName, temp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo(cityName, temp) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildTopNavigationBar(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName,
              style: Themes.cityText,
            ),
            IconButton(
              key: favoriteKey,
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.yellow : Colors.white,
              ),
              onPressed: toggleFavoriteCity,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "$temp°",
          style: Themes.mainTempText,
        ),
        ForecastInfo(
          isValueByDays: _isValueByDays,
          data: _data,
        ),
        ForecastDetails(
          data: _data,
        ),
      ],
    );
  }

  Widget _buildTopNavigationBar() {
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
      currentIndex: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.white,
      onTap: (index) async {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FavoritesPageWithComparison(
                onCitySelected: (city) {
                  setState(() {
                    _city = city;
                  });
                },
              ),
            ),
          );
        }

        if (index == 2) {
          final shouldSignOut = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Підтвердження'),
                content: const Text('Ви дійсно хочете вийти з акаунту?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Скасувати'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Вийти'),
                  ),
                ],
              );
            },
          );

          if (shouldSignOut == true) {
            await FirebaseAuth.instance.signOut();
          }
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: AppStrings.bottomNavigationBarLabelWeather,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: AppStrings.bottomNavigationBarLabelFavorite,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout_rounded),
          label: AppStrings.bottomNavigationBarLabelLogOut,
        ),
      ],
    );
  }
}
