// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:clima_v2/Services/location.dart';
import 'package:clima_v2/core/constants.dart';
import 'package:clima_v2/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/networking.dart';
import '../Services/weather.dart';
import 'city_screen.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  LocationScreen({super.key, required this.currentLocationDetails});
  dynamic currentLocationDetails;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String cityName = '';
  int condition = 0;
  dynamic iconSelected;
  String selectedText = '';
  @override
  void initState() {
    super.initState();
    UpdateUI(widget.currentLocationDetails);
  }

  void UpdateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        iconSelected = 'error';
        selectedText = 'Unable to get weather data!';
        cityName = '';
      }
      temperature = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      condition = weatherData['weather'][0]['id'];
      WeatherModel weatherModel = WeatherModel();
      iconSelected = weatherModel.getWeatherIcon(condition);
      selectedText = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic typedName;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await Location().SetLocation();
                      dynamic temp = await WeatherModel().GetWeatherData();
                      dynamic finalTemp = await jsonDecode(temp.toString());
                      UpdateUI(finalTemp);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      typedName = await Get.toNamed(rCityScreen);
                      if (typedName != null) {
                        String weatherDetailsOfCity =
                            await NetworkHelper().CityNetworkData(typedName);
                        dynamic finalWeatherDetails =
                            await jsonDecode(weatherDetailsOfCity.toString());
                        UpdateUI(finalWeatherDetails);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$iconSelected',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$selectedText in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
