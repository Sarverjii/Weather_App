import 'package:flutter/material.dart';
import 'package:weather_app/API%20related%20Stuff/api_class.dart';
import 'package:intl/intl.dart';

class Dataprocessing {
  APISTUFF apiClass = APISTUFF();
  Map<String, dynamic>? latestForecast;
  DateTime? latestDateTime;

  Dataprocessing(String cityName, String countryCode) {
    apiClass = APISTUFF(cityName: cityName, countryCode: countryCode);
  }

  Future<Map<String, dynamic>> foreCast() {
    var data = apiClass.getDatafromAPI();
    return data;
  }

  Future<List<String>> refresh() async {
    String errormessage = await apiClass.errorMessage();
    var temp = await fetchTemp();
    var weather = await fetchWeather();
    var weatherdescription = await fetchWeatherdescrition();
    var feelsLike = await fetchFeelsLike();
    var maxTemp = await fetchmaxTemp();
    var minTemp = await fetchminTemp();

    var humidityvalue = await humidity();
    var pressurevalue = await pressure();
    var windvalue = await wind();
    return [
      errormessage,
      temp,
      weather,
      weatherdescription,
      feelsLike,
      maxTemp,
      minTemp,
      humidityvalue,
      pressurevalue,
      windvalue
    ];
  }

  Future<Map<String, dynamic>> getLatestForecast() async {
    if (latestForecast != null && latestDateTime != null) {
      // Return cached values if available
      return latestForecast!;
    }

    var data = await apiClass.getDatafromAPI();
    var list = data['list'];

    DateTime now = DateTime.now();
    DateTime? tempLatestDateTime;
    Map<String, dynamic>? tempLatestForecast;

    for (var i = 0; i < 8; i++) {
      var item = list[i];
      DateTime itemDateTime =
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(item['dt_txt']);

      // Only consider past forecast data
      if (itemDateTime.isBefore(now) &&
          (tempLatestDateTime == null ||
              tempLatestDateTime.isBefore(itemDateTime))) {
        tempLatestDateTime = itemDateTime;
        tempLatestForecast = item;
      }
    }

    // Cache the values
    latestDateTime = tempLatestDateTime;
    latestForecast = tempLatestForecast;

    return latestForecast ?? {};
  }

  Future<String> fetchTemp() async {
    var data = await getLatestForecast();
    return (data['main']['temp'] - 273.15).toStringAsFixed(1);
  }

  Future<String> fetchWeather() async {
    var data = await getLatestForecast();
    return (data['weather'][0]['main']).toString();
  }

  Future<String> fetchWeatherdescrition() async {
    var data = await getLatestForecast();
    return data['weather'][0]['description'].toString();
  }

  Future<String> fetchFeelsLike() async {
    var data = await getLatestForecast();
    return (data['main']['feels_like'] - 273.15).toStringAsFixed(1);
  }

  Future<String> fetchmaxTemp() async {
    var data = await getLatestForecast();
    return (data['main']['temp_max'] - 273.15).toStringAsFixed(1);
  }

  Future<String> fetchminTemp() async {
    var data = await getLatestForecast();
    return (data['main']['temp_min'] - 273.15).toStringAsFixed(1);
  }

  Future<String> humidity() async {
    var data = await getLatestForecast();
    return data['main']['humidity'].toString();
  }

  Future<String> pressure() async {
    var data = await getLatestForecast();
    return data['main']['pressure'].toString();
  }

  Future<String> wind() async {
    var data = await getLatestForecast();
    return data['wind']['speed'].toString();
  }

  IconData iconWeatherForcast(String data) {
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

  Future<IconData> fetchIcon() async {
    var data = await getLatestForecast();

    switch (data['weather'][0]['main']) {
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

  String formatDateTime(String dateTimeString) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat("dd-MM-yy").format(dateTime);
    String formattedTime = DateFormat("HH:mm").format(dateTime);

    // Combine date and time with a newline character
    return "$formattedDate\n$formattedTime";
  }

  // Getter for latestDateTime
  DateTime? get getLatestDateTime => latestDateTime;

  // Getter for latestForecast
  Map<String, dynamic>? get getLatestForecastData => latestForecast;
}
