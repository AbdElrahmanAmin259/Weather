import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _weatherServices = WeatherServices("f421aebe8b48b3a2a1bb7947749e600b");
  Weatherinfo? _weather;

  Future<void> _fetchWeather() async {
    try {
      final position = await _weatherServices.getCurrentLocation();

      final weather = await _weatherServices.getweatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      print("Weather data: ${weather.temperature}℃");

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String getweatheranimation(String? maincondition) {
    if (maincondition == null) return "assets/sunny.json";

    switch (maincondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
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
      backgroundColor: Colors.grey[800],
      body: Container(
        child: Center(
          child: _weather == null
              ? const CircularProgressIndicator(color: Colors.white)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 📍 City Name
                    Text(
                      _weather!.cityname,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Lottie.asset(
                      getweatheranimation(_weather!.maincondition),
                      height: 150,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      '${_weather!.temperature.round()}℃',
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      _weather!.maincondition,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
