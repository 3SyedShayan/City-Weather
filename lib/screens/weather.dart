import 'package:flutter/material.dart';
import 'package:my_city_weather/models/weather_model.dart';
import 'package:my_city_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  final _weatherService = WeatherService('f9e48efdea84d4319049d3f036def82d');
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather2 = await _weatherService.getWeather(cityName);
      print(weather2.runtimeType);

      setState(() {
        _weather = weather2;
      });
      print(_weather.runtimeType);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("City Name : ${_weather?.cityName}"),
      ),
    );
  }
}
