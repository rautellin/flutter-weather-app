import 'package:flutter/material.dart';
import '../utilities/styles.dart' as Styles;
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  String city;
  String weatherIcon;
  String weatherMessage;

  Weather weather = Weather();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        city = '';
        return;
      }
      temperature = weatherData['main']['temp'];
      city = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(weatherData['weather'][0]['id']);
      weatherMessage = weather.getMessage(temperature.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/location_background.jpg'),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      dynamic weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        dynamic weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: Styles.TempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: Styles.ConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $city',
                  textAlign: TextAlign.right,
                  style: Styles.MessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
