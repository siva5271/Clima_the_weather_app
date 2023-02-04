// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:clima_v2/Screens/location_screen.dart';
import 'package:clima_v2/Screens/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/location.dart';
import '../Services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void setUpPage() async {
    dynamic currentWeatherDetails;
    Location object = Location();
    await object.SetLocation();
    currentWeatherDetails = await WeatherModel().GetWeatherData();
    dynamic finalWeatherDetaills = jsonDecode(currentWeatherDetails.toString());
    Get.to(LocationScreen(
      currentLocationDetails: finalWeatherDetaills,
    ));
  }

  @override
  void initState() {
    super.initState();
    setUpPage();
  }

  @override
  Widget build(BuildContext context) {
    return const WaitingScreen();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
