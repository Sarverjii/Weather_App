import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/API%20related%20Stuff/DataProcessing.dart';
import 'package:weather_app/widgets/Additional_Info_Container.dart';
import 'package:weather_app/widgets/Hourly_Forcast_Items.dart';
import 'package:weather_app/widgets/CitySelectionDialog.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String selectedCity = 'Dehradun'; // Default city
  String selectedCountryCode = 'IN'; // Default country code

  late Dataprocessing dataprocessing;
  Future<void>? forecastFuture;

  var forecastCounter = 0;

  String temp = "";
  String weather = "";
  String weatherdescription = "";
  String feelLike = "";
  String MaxTemp = "";
  String MinTemp = "";
  String Humidity = "";
  String Pressure = "";
  String Wind = "";

  IconData mainIcon = Icons.error_outline;

  var forecastData;

  @override
  void initState() {
    super.initState();
    dataprocessing = Dataprocessing(selectedCity, selectedCountryCode);
    forecastFuture = fetchForeCast(); // Store the future
  }

  Future<void> fetchForeCast() async {
    try {
      forecastCounter = 0;
      var data = await dataprocessing.refresh();
      IconData data1 = await dataprocessing.fetchIcon();
      forecastData = await dataprocessing.foreCast();

      setState(() {
        temp = data[1];
        weather = data[2];
        weatherdescription = data[3];
        feelLike = data[4];
        MaxTemp = data[5];
        MinTemp = data[6];
        Humidity = data[7];
        Pressure = data[8];
        Wind = data[9];
        mainIcon = data1;
      });
    } catch (e) {
      setState(() {
        print("Error fetching forecast: $e");
      });
    }
  }

  void _showCitySelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CitySelectionDialog(
          onCitySelected: (city, countryCode) {
            setState(() {
              selectedCity = city;
              dataprocessing = Dataprocessing(selectedCity, countryCode);
              forecastFuture = fetchForeCast(); // Update the future
            });
          },
        );
      },
    );
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
            onPressed: _showCitySelectionDialog,
            icon: const Icon(Icons.location_city),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                forecastFuture = fetchForeCast();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<void>(
          future: forecastFuture, // Use the future variable here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Card
                    Container(
                      width: double.infinity,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        elevation: 20,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "$selectedCity, $selectedCountryCode",
                                  style: const TextStyle(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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

                    // Weather Forecast
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Weather Forecast",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                          HourlyForcastItems(
                            iconn: dataprocessing.iconWeatherForcast(
                                forecastData['list'][forecastCounter]['weather']
                                    [0]['main']),
                            weatherdescription: forecastData['list']
                                [forecastCounter]['weather'][0]['description'],
                            temp: (forecastData['list'][forecastCounter]['main']
                                        ['temp'] -
                                    273.15)
                                .toStringAsFixed(1),
                            weather: forecastData['list'][forecastCounter]
                                ['weather'][0]['main'],
                            time: dataprocessing.formatDateTime(
                                forecastData['list'][forecastCounter++]
                                    ['dt_txt']),
                          ),
                        ],
                      ),
                    ),

                    // Additional Information
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoContainer(
                          iconn: Icons.water_drop,
                          heading: "Humidity",
                          value: Humidity,
                        ),
                        AdditionalInfoContainer(
                          iconn: Icons.air,
                          heading: "Wind",
                          value: Wind,
                        ),
                        AdditionalInfoContainer(
                          iconn: Icons.beach_access,
                          heading: "Pressure",
                          value: Pressure,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // City Choosing
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
