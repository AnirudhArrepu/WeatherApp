import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'additional_info_item.dart';
import 'hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String apiKey = '706e4d6d2ac68b862b30467e306d2682';
      String cityName = 'Hyderabad';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey'),
      );

      final data = jsonDecode(res.body);

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          final data = snapshot.data!;
          var currentTemp = (data['list'][0]['main']['temp']-273.00).toStringAsFixed(2);
          var currentSky = data['list'][0]['weather'][0]['main'];
          var currentHumidity = data['list'][0]['main']['humidity'];
          var currentWindSpeed = data['list'][0]['wind']['speed'];
          var currentPressure = data['list'][0]['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //current temp card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '$currentTemp°C',
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Icon(
                            currentSky == 'Clouds' || currentSky == 'Rain'
                                ? (currentSky == 'Clouds'? Icons.cloud : Icons.water_drop)
                                : Icons.sunny,
                            size: 70,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$currentSky',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                //forecast card
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 8; i++)
                        HourlyForecastItem(
                          time: DateFormat.j().format(DateTime.parse(data['list'][i + 1]['dt_txt'])),
                          icon: data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? (data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ? Icons.cloud : Icons.water_drop)
                              : Icons.sunny,
                          temperature:
                              (data['list'][i + 1]['main']['temp']-273.00).toStringAsFixed(2)+'°C',
                        )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //additional info
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Additional Inforrmation',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      type: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      type: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                        icon: Icons.beach_access,
                        type: 'Pressure',
                        value: currentPressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
