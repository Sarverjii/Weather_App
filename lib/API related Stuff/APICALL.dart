import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/API%20related%20Stuff/secrects.dart';

class APISTUFF {
  final String cityName;
  final String countryCode;
  Map<String, dynamic>? _cachedData;

  APISTUFF({this.cityName = "Delhi", this.countryCode = "IN"});

  Future<Map<String, dynamic>> getDatafromAPI() async {
    if (_cachedData == null) {
      try {
        final res = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$countryCode&APPID=$MYAPIID"));

        var data = jsonDecode(res.body);

        if (data['cod'] != '200') {
          throw data['message'];
        }

        _cachedData = data; // Cache the data after the first request
      } catch (e) {
        throw e.toString();
      }
    }
    return _cachedData!;
  }

  Future<String> errorMessage() async {
    var data = await getDatafromAPI();
    String value = data['message'].toString();
    return value;
  }

  Future<String> temperature() async {
    var data = await getDatafromAPI();
    String value =
        (data['list'][0]['main']['temp'] - 273.15).toStringAsFixed(1);
    return value;
  }

  Future<String> weather() async {
    var data = await getDatafromAPI();
    String value = data['list'][0]['weather'][0]['main'];

    return value;
  }

  Future<String> weatherdescprition() async {
    var data = await getDatafromAPI();
    String value = data['list'][0]['weather'][0]['description'];

    return value;
  }

  Future<String> Humidity() async {
    var data = await getDatafromAPI();
    String value = data['list'][0]['main']['humidity'].toString();

    return value;
  }

  Future<String> Wind() async {
    var data = await getDatafromAPI();
    String value = data['list'][0]['wind']['speed'].toString();

    return value;
  }

  Future<String> Pressure() async {
    var data = await getDatafromAPI();
    String value = data['list'][0]['main']['pressure'].toString();

    return value;
  }

  Future<String> feelLike() async {
    var data = await getDatafromAPI();
    String value =
        (data['list'][0]['main']['feels_like'] - 273.15).toStringAsFixed(1);

    return value;
  }

  Future<String> MaxTemp() async {
    var data = await getDatafromAPI();
    String value =
        (data['list'][0]['main']['temp_max'] - 273.15).toStringAsFixed(1);

    return value;
  }

  Future<String> MinTemp() async {
    var data = await getDatafromAPI();
    String value =
        (data['list'][0]['main']['temp_min'] - 273.15).toStringAsFixed(1);

    return value;
  }
}
