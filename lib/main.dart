import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:list_app/screens/landing_screen.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/shared%20preference/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStore.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = window.physicalSize.width;
    return MaterialApp(
      theme: ThemeData(
          textTheme: size > 500 ? textThemeLarge : textThemeSmall,
          primaryColor: accentLight),
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
