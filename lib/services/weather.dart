import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'location.dart';
import 'networking.dart';

const openWeatherMapURL = 'https://api.openweathermap.org';
String apiKey = dotenv.env['APIKEY'];

class Weather {
  Future getCityWeather(String cityName) async {
    NetworkHelper networking = NetworkHelper(
        url: openWeatherMapURL,
        path: '/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    dynamic weatherData = await networking.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url: openWeatherMapURL,
        path:
            '/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    dynamic weatherData = await networkHelper.getData();
    return weatherData;
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
