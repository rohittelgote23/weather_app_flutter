import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart'; // Import FL Chart library
import 'package:weather_app/charts_flutter.dart';
import 'package:weather_app/sunrise.dart';
import 'additional_info.dart';
import 'apikey.dart';
import 'hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  const WeatherScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  String cityName = "Pune";

  String capitalizeFirstLetter(String input) {
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openweatherapikey'));

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw "An unexpected error occurred";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(widget.isDarkTheme ? Icons.wb_sunny : Icons.nights_stay),
          onPressed: widget.toggleTheme,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTempKelvin = currentWeatherData['main']['temp'];
          final currentTemp =
              ((currentTempKelvin * (9 / 5)) - 459.67).toStringAsFixed(2);
          final currentSkyDescription =
              currentWeatherData['weather'][0]['description'];
          final currentSeaLevel = currentWeatherData['main']['sea_level'];
          final currentWind = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentTimeDate = DateFormat('EEEE, MMM dd')
              .format(DateTime.parse(currentWeatherData['dt_txt']));

          final iconCode = currentWeatherData['weather'][0]['icon'];

          final country = data['city']['country'];
          final displayedCityName = data['city']['name'];

          final sunrise = DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(
                  data['city']['sunrise'] * 1000));
          final sunset = DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(
                  data['city']['sunset'] * 1000));

          // Extracting temperatures for the chart
          List<FlSpot> spots = [];
          for (int i = 0; i < 8; i++) {
            double tempKelvin = data['list'][i]['main']['temp'];
            double tempFahrenheit = ((tempKelvin * (9 / 5)) - 459.67);
            tempFahrenheit = double.parse(tempFahrenheit
                .toStringAsFixed(2)); // Limit to two decimal places
            spots.add(FlSpot(i.toDouble(), tempFahrenheit));
          }

          List<FlSpot> windspots = [];
          for (int i = 0; i < 8; i++) {
            double windY = data['list'][i]['wind']['speed'].toDouble();// Limit to two decimal places
            windspots.add(FlSpot(i.toDouble(), windY));
          }

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search City",
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            // displayedCityName = cityName;
                            weather = getCurrentWeather();
                          });
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cityName = value.isEmpty ? "Pune" : value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          cityName = "Pune";
                        } else {
                          cityName = value;
                          // displayedCityName = cityName;
                          weather = getCurrentWeather();
                        }
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    '$displayedCityName $country | $currentTimeDate',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp °F',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.network(
                                "http://openweathermap.org/img/wn/$iconCode@4x.png",
                                height: 140,
                                width: 140,
                              ),
                              Text(
                                capitalizeFirstLetter(currentSkyDescription),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Hourly Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlyTemp =
                            ((hourlyForecast['main']['temp'] * (9 / 5)) -
                                    459.67)
                                .toStringAsFixed(2);
                        final hourlyTime =
                            DateTime.parse(hourlyForecast['dt_txt']);
                        final hourlyIconCode =
                            hourlyForecast['weather'][0]['icon'];

                        return HourlyForecastItem(
                          day: DateFormat('EEEE').format(hourlyTime),
                          time: DateFormat('h a').format(hourlyTime),
                          temperature: hourlyTemp,
                          icon: hourlyIconCode.toString(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: '$currentHumidity%',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: '$currentWind KpH',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.water,
                        label: "Sea Level",
                        value: currentSeaLevel.toString(),
                      ),
                    ],
                  ),
                  
                  
                  const SizedBox(height: 25),
                  const Text(
                    'Temperature',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 200,
                    child: TempLineChart(
                      
                      miny: 0,
                      maxy: 140,
                      spots: spots,
                      bottomTitle: "Temperature",
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Wind Speed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 200,
                    child: TempLineChart(
                     
                      miny: 0,
                      maxy: 10,
                      spots: windspots,
                       bottomTitle: "Wind Speed",
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Sunrise & Sunset',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Sunrise(
                        sunicon: Icons.sunny,
                        sunlabel: "Sunrise",
                        sunvalue: sunrise,
                      ),
                      Sunrise(
                        sunicon: CupertinoIcons.moon_fill,
                        sunlabel: "Sunset",
                        sunvalue: sunset,
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
