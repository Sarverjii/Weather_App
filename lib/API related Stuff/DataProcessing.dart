import 'package:flutter/material.dart';
import 'package:weather_app/API%20related%20Stuff/APICALL.dart';

class Dataprocessing {
  APISTUFF APIClass = APISTUFF();
  Dataprocessing(String cityName, String countryCode) {
    APIClass = APISTUFF(cityName: cityName, countryCode: countryCode);
  }

  Future<List<String>> refresh() async {
    var temp = await fetchTemp();
    var weather = await fetchWeather();
    var weatherdescription = await fetchWeatherdescrition();
    var feelsLike = await fetchFeelsLike();
    var MaxTemp = await fetchMaxTemp();
    var MinTemp = await fetchMinTemp();
    return [temp, weather, weatherdescription, feelsLike, MaxTemp, MinTemp];
  }

  Future<String> fetchTemp() async {
    var data = await APIClass.temperature();
    return data.toString();
  }

  Future<String> fetchWeather() async {
    var data = await APIClass.weather();
    return data.toString();
  }

  Future<String> fetchWeatherdescrition() async {
    var data = await APIClass.weatherdescprition();
    return data.toString();
  }

  Future<String> fetchFeelsLike() async {
    var data = await APIClass.feelLike();
    return data.toString();
  }

  Future<String> fetchMaxTemp() async {
    var data = await APIClass.MaxTemp();
    return data.toString();
  }

  Future<String> fetchMinTemp() async {
    var data = await APIClass.MinTemp();
    return data.toString();
  }

  Future<IconData> fetchIcon() async {
    var data = await APIClass.weather();
    switch (data) {
      case "Clear":
        return Icons.wb_sunny;
      case "Clouds":
        return Icons.cloud;
      case "Drizzle":
        return Icons.grain;
      case "Rain":
        return Icons.beach_access_rounded;
      case "Thunderstorm":
        return Icons.flash_on;
      case "Snow":
        return Icons.ac_unit;
      case "Mist":
        return Icons.blur_on;
      case "Fog":
        return Icons.blur_circular;
      case "Smoke":
        return Icons.smoke_free;
      case "Haze":
        return Icons.filter_drama;
      case "Dust":
        return Icons.air;
      case "Ash":
        return Icons.terrain;
      case "Squall":
        return Icons.storm;
      case "Tornado":
        return Icons.waves;
    }
    return Icons.error_outline;
  }
}
