import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_city_weather/models/weather_model.dart';
import 'package:my_city_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  final _weatherService = WeatherService('f9e48efdea84d4319049d3f036def82d');
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      print(weather.runtimeType);

      setState(() {
        _weather = weather;
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
        child: Column(
          children: [
            Text(_weather?.cityName ?? 'Loading...'),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),
            Text('${_weather?.temperature.round()} Celsius'),
            // Text(_weather?.mainCondition ?? 'Loading...'),
          ],
        ),
      ),
    );
  }
}
