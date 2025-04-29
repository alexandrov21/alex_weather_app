import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_3/models/forecast_model.dart';
import 'package:task_3/services/weather_api_client.dart';

class FavoritesPageWithComparison extends StatefulWidget {
  const FavoritesPageWithComparison({super.key, required this.onCitySelected});

  final Function(String) onCitySelected;

  @override
  State<FavoritesPageWithComparison> createState() => _FavoritesPageWithComparisonState();
}

class _FavoritesPageWithComparisonState extends State<FavoritesPageWithComparison> {
  final WeatherApiClient _client = WeatherApiClient();
  final user = FirebaseAuth.instance.currentUser;
  List<String> favoriteCities = [];
  Map<String, ForecastModel> weatherData = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .get();

    final cities = snapshot.docs.map((doc) => doc.id).toList();

    final Map<String, ForecastModel> data = {};
    for (final city in cities) {
      final weather = await _client.getCurrentWeather(city);
      if (weather != null) {
        data[city] = weather;
      }
    }

    setState(() {
      favoriteCities = cities;
      weatherData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Будь ласка, увійдіть у акаунт")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Улюблені міста")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...favoriteCities.map((city) {
              return ListTile(
                title: Text(city),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  widget.onCitySelected(city);
                  Navigator.pop(context);
                },
              );
            }),
            const SizedBox(height: 24),
            _buildBody(),
            // if (weatherData.isNotEmpty)
            //   _buildComparisonTable()
            // else
            //   const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Місто", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Темп.", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Відч.", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Вологість", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Тиск", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Вітер", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        ...weatherData.entries.map((entry) {
          final city = entry.key;
          final data = entry.value;
          final main = data.list?.first.main;
          final wind = data.list?.first.wind;

          final temp = main?.temp?.toStringAsFixed(1) ?? 'N/A';
          final feelsLike = main?.feels_like?.toStringAsFixed(1) ?? 'N/A';
          final humidity = main?.humidity?.toString() ?? 'N/A';
          final pressure = main?.pressure?.toString() ?? 'N/A';
          final windSpeed = wind?.speed?.toStringAsFixed(1) ?? 'N/A';

          return TableRow(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: Text(city)),
              Padding(padding: const EdgeInsets.all(8), child: Text("$temp °C")),
              Padding(padding: const EdgeInsets.all(8), child: Text("$feelsLike °C")),
              Padding(padding: const EdgeInsets.all(8), child: Text("$humidity %")),
              Padding(padding: const EdgeInsets.all(8), child: Text("$pressure hPa")),
              Padding(padding: const EdgeInsets.all(8), child: Text("$windSpeed м/с")),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.grey.withOpacity(0.3), // напівпрозорий сірий фон
        ),
        child: _buildForecastComparison(),
      ),
    );
  }

  Widget _buildForecastComparison() {
    final cities = weatherData.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.2)),
          columns: const [
            DataColumn(label: Text("Місто", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Температура", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Вологість", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Тиск", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Швид. вітру", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Відчувається як", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: cities.map((city) {
            final data = weatherData[city];
            final main = data?.list?.first.main;
            final wind = data?.list?.first.wind;

            return DataRow(cells: [
              DataCell(Text(city)),
              DataCell(Text("${main?.temp?.toStringAsFixed(1) ?? "—"} °C")),
              DataCell(Text("${main?.humidity?.toString() ?? "—"} %")),
              DataCell(Text("${main?.pressure?.toString() ?? "—"} hPa")),
              DataCell(Text("${wind?.speed?.toStringAsFixed(1) ?? "—"} м/с")),
              DataCell(Text("${main?.feels_like?.toStringAsFixed(1) ?? "—"} °C")),
            ]);
          }).toList(),
        ),
      ),
    );
  }


}
