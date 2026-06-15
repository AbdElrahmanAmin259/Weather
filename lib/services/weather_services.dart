import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apikey;

  WeatherServices(this.apikey);

  // 🔥 NEW: get weather using latitude & longitude
  Future<Weatherinfo> getweatherByCoordinates(double lat, double lon) async {
    final response = await http.get(
      Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apikey&units=metric"),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      return Weatherinfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  // 🔥 get current location (lat/lon)
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // 👇 اختياري (لو عايز اسم المدينة للعرض بس)
  Future<String> getCurrentCity() async {
    Position position = await getCurrentLocation();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) return "Unknown";

    return placemarks[0].locality ?? "Unknown";
  }
}
