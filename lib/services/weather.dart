import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  String apiKey = dotenv.env['APIKEY'];

  Future getWeather() async {
    Location location = Location();

    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      location.longitude = jsonDecode(data)['coord']['lon'];
      location.latitude = jsonDecode(data)['coord']['lat'];
    } else {
      print(response.statusCode);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
