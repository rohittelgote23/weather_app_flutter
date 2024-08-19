
import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String icon;
  final String temperature;
  final String day;

  const HourlyForecastItem({super.key,
  required this.time,
  required this.temperature,
  required this.icon,
  required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child:  Column(
          children: [
            
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            Image.network("http://openweathermap.org/img/wn/$icon.png",
            height: 50,width: 64,),
            
            Text(
              temperature,
            ),
            
            Text(
              day,
              style: const TextStyle(fontSize: 16,
              wordSpacing: 1),
            ),
                   
          ],
        ),
      ),
    );
  }
}
