import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:country_codes/country_codes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // tz.initializeTimeZones();
  // await CountryCodes.init();
  await Firebase.initializeApp();
  runApp(const App());
}
