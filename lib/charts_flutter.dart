import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TempLineChart extends StatefulWidget {
  final int miny;
  final int maxy;
  final List<FlSpot> spots;
  final String bottomTitle;

  const TempLineChart({
    Key? key,
    required this.spots,
    required this.miny,
    required this.maxy,
    required this.bottomTitle,
  }) : super(key: key);

  @override
  State<TempLineChart> createState() => _TempLineChartState();
}

class _TempLineChartState extends State<TempLineChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      
      LineChartData(
        minY: widget.miny.toDouble(),
        maxY: widget.maxy.toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: widget.spots,
            dotData: const FlDotData(show: true),
            isCurved: true
          ),
        ],
        titlesData: FlTitlesData(
          
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              widget.bottomTitle,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                height: 1.2
                // fontSize: 16,
              ),
            ),
            
            sideTitles: const SideTitles(showTitles: false) // Hides actual titles
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 0.5,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 0.5,
            );
          },
        ),
      ),
    );
  }
}
