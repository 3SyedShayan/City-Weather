import 'package:flutter/material.dart';
import 'package:my_city_weather/services/weather_service.dart';

class Weather extends StatefulWidget {
  Weather({super.key});
  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _weatherService = WeatherService('There is Something');
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather as Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_weather?.cityName ?? "City Name.."),
      ),
    );
  }
}
