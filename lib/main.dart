import 'package:clima_v2/Screens/city_screen.dart';
import 'package:clima_v2/Screens/loading_screen.dart';
import 'package:clima_v2/Screens/location_screen.dart';
import 'package:clima_v2/Screens/waiting_screen.dart';
import 'package:clima_v2/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
      getPages: [
        GetPage(name: rLoadingScreen, page: () => LoadingScreen()),
        GetPage(name: rCityScreen, page: () => CityScreen()),
        GetPage(name: rWaitingScreen, page: () => const WaitingScreen())
      ],
    );
  }
}
