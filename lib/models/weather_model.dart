class Weatherinfo {
  final String cityname;
  final double temperature;
  final String maincondition;

  Weatherinfo({
    required this.cityname,
    required this.maincondition,
    required this.temperature,
  });

  factory Weatherinfo.fromJson(Map<String, dynamic> json) {
    return Weatherinfo(
      cityname: json["name"],
      temperature: (json["main"]["temp"] as num).toDouble(),
      maincondition: json["weather"][0]["main"],
    );
  }
}
