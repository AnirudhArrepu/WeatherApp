import 'package:flutter/material.dart';
// import 'package:weather_icons/weather_icons.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem(
      {super.key, required this.time,required this.temperature, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [  
              Text(
                time,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Icon(
                icon,
                size: 35,
              ),
              SizedBox(height: 10),
              Text(
                temperature,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
