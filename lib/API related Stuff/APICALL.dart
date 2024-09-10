import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/API%20related%20Stuff/secrects.dart';

class APISTUFF {
  // APISTUFF({required this.cityName, required this.countryCode});

  Future getDatafromAPI() async {
    try {
      String cityName = "Dehradun";
      String countryCode = "IN";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$countryCode&APPID=$MYAPIID"));

      var data = jsonDecode(res.body);

      if (int.parse(data['cod']) != 200) {
        throw "An unexpected Error Occured";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> temperature() async {
    try {
      var data = await getDatafromAPI();
      String value =
          (data['list'][0]['main']['temp'] - 273.15).toStringAsFixed(1);
      return value;
    } catch (e) {
      throw e;
    }
  }

  Future<String> weather() async {
    try {
      var data = await getDatafromAPI();
      String value = data['list'][0]['weather'][0]['main'];

      return value;
    } catch (e) {
      throw e;
    }
  }

  Future<String> weatherdescprition() async {
    try {
      var data = await getDatafromAPI();
      String value = data['list'][0]['weather'][0]['description'];

      return value;
    } catch (e) {
      throw e;
    }
  }

  Future<String> feelLike() async {
    try {
      var data = await getDatafromAPI();
      String value =
          (data['list'][0]['main']['feels_like'] - 273.15).toStringAsFixed(1);

      return value;
    } catch (e) {
      throw e;
    }
  }

  Future<String> MaxTemp() async {
    try {
      var data = await getDatafromAPI();
      String value =
          (data['list'][0]['main']['temp_max'] - 273.15).toStringAsFixed(1);

      return value;
    } catch (e) {
      throw e;
    }
  }

  Future<String> MinTemp() async {
    try {
      var data = await getDatafromAPI();
      String value =
          (data['list'][0]['main']['temp_min'] - 273.15).toStringAsFixed(1);

      return value;
    } catch (e) {
      throw e;
    }
  }
}
