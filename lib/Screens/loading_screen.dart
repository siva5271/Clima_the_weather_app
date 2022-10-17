import 'dart:convert';

import 'package:clima_v2/Screens/location_screen.dart';
import 'package:clima_v2/Screens/waiting_screen.dart';
import 'package:flutter/material.dart';

import '../Services/location.dart';
import '../Services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void SetupPage() async {
    dynamic currentWeatherDetails;
    Location object = Location();
    await object.SetLocation();
    currentWeatherDetails = await WeatherModel().GetWeatherData();
    dynamic finalWeatherDetaills = jsonDecode(currentWeatherDetails.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          currentLocationDetails: finalWeatherDetaills,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetupPage();
  }

  @override
  Widget build(BuildContext context) {
    return WaitingScreen();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}
