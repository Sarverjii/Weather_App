import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/API%20related%20Stuff/APICALL.dart';
import 'package:weather_app/API%20related%20Stuff/DataProcessing.dart';
import 'package:weather_app/widgets/Additional_Info_Container.dart';
import 'package:weather_app/widgets/Hourly_Forcast_Items.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Dataprocessing dataprocessing = Dataprocessing();
  APISTUFF apistuff = APISTUFF();

  String temp = "";
  String weather = "";
  String weatherdescription = "";
  String feelLike = "";
  String MaxTemp = "";
  String MinTemp = "";
  IconData mainIcon = Icons.error_outline;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchForeCast();
    });
  }

  Future<void> fetchForeCast() async {
    try {
      var data = await dataprocessing.refresh();
      IconData data1 = await dataprocessing.fetchIcon();

      setState(() {
        temp = data[0];
        weather = data[1];
        weatherdescription = data[2];
        feelLike = data[3];
        MaxTemp = data[4];
        MinTemp = data[5];

        mainIcon = data1;
      });
    } catch (e) {
      print("Error: $e");
    }
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
                fetchForeCast();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
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
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: [
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // Text(
                          //   apistuff.cityName + " , " + apistuff.countryCode,
                          //   style: const TextStyle(
                          //       decoration: TextDecoration.underline,
                          //       fontSize: 25,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "$temp°C",
                                      style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Icon(
                                      mainIcon,
                                      size: 64,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      weatherdescription,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      weather,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Feels Like",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      feelLike,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      "Maximum\nTemperature",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      MaxTemp,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      "Minimum\nTemperature",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      MinTemp,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ]),
                        ]),
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
              const SizedBox(
                height: 20,
              ),

              const Placeholder(
                fallbackHeight: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
