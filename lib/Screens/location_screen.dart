import 'dart:convert';

import 'package:clima_v2/Services/location.dart';
import 'package:clima_v2/constants.dart';
import 'package:flutter/material.dart';

import '../Services/networking.dart';
import '../Services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.currentLocationDetails});
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
    // TODO: implement initState
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
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
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
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (typedName != null) {
                        String weatherDetailsOfCity =
                            await NetworkHelper().CityNetworkData(typedName);
                        dynamic finalWeatherDetails =
                            await jsonDecode(weatherDetailsOfCity.toString());
                        UpdateUI(finalWeatherDetails);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
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
                padding: EdgeInsets.only(right: 15.0),
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
