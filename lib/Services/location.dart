import 'package:clima_v2/core/constants.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<void> SetLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      kCurrentLongitude = position.longitude;
      kCurrentLatitude = position.latitude;
      print(position);
    } catch (e) {
      print(e.toString());
    }
  }
}

//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
