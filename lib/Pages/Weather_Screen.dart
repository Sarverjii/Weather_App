import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secrects.dart';
import 'package:weather_app/widgets/Additional_Info_Container.dart';
import 'package:weather_app/widgets/Hourly_Forcast_Items.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    String cityName = "Dehradun";
    String countryCode = "IN"; // Country code for India
    final res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName,$countryCode&APPID=$MYAPIID"));

    var data = jsonDecode(res.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                getCurrentWeather();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Main Card
            Container(
              width: double.infinity,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                elevation: 20,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "300.67°F",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Rain",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Weather Forcast

            const SizedBox(
              height: 20,
            ),

            const Text(
              "Weather Forcast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItems(
                    iconn: Icons.cloud,
                    temp: "301.2°F",
                    time: "09:00",
                  ),
                  HourlyForcastItems(
                    iconn: Icons.sunny,
                    temp: "320.2°F",
                    time: "12:00",
                  ),
                  HourlyForcastItems(
                    iconn: Icons.cloudy_snowing,
                    temp: "301.2°F",
                    time: "15:00",
                  ),
                  HourlyForcastItems(
                    iconn: Icons.flash_on,
                    temp: "288.2°F",
                    time: "18:00",
                  ),
                  HourlyForcastItems(
                    iconn: Icons.blur_on,
                    temp: "278.2°F",
                    time: "21:00",
                  ),
                ],
              ),
            ),

            //Addition Information
            const SizedBox(
              height: 20,
            ),

            const Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoContainer(
                  iconn: Icons.water_drop,
                  heading: "Humidity",
                  value: "94",
                ),
                AdditionalInfoContainer(
                  iconn: Icons.air,
                  heading: "Wind",
                  value: "7.67",
                ),
                AdditionalInfoContainer(
                  iconn: Icons.beach_access,
                  heading: "Pressure",
                  value: "1006",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
