import 'package:clima_v2/core/constants.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<String> NetworkData() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$kCurrentLatitude&lon=$kCurrentLongitude&appid=724f55ad223d3e89029943d9560981f8&units=metric'),
      );
      print(response.body);
      return (response.body);
    } catch (e) {
      return (e.toString());
    }
  }

  Future<String> CityNetworkData(cityName) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=724f55ad223d3e89029943d9560981f8&units=metric'),
      );
      print(response.body);
      return (response.body);
    } catch (e) {
      return (e.toString());
    }
  }
}
