import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_page.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weather(),
    );
  }
}
