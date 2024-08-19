import 'package:flutter/material.dart';

class Sunrise extends StatelessWidget {
  final IconData sunicon;
  final String sunlabel;
  final String sunvalue;

  const Sunrise({
    super.key,
    required this.sunicon,
    required this.sunlabel,
    required this.sunvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8,10,8,10),
        width: 120,
        child: Column(
          children: [
            Icon(
              sunicon,
              size: 35,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              sunlabel,
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            
            
            Text(
              sunvalue,
              style: const TextStyle(fontSize: 16, ),
            ),
          ],
        ),
      ),
    );
  }
}
