import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartTemperature extends StatefulWidget {
  Map<double, double> data;

  LineChartTemperature({this.data});

  @override
  _LineChartTemperatureState createState() => _LineChartTemperatureState();
}

class _LineChartTemperatureState extends State<LineChartTemperature> {
  List<Color> gradientColors = [
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orange,
    Colors.redAccent,
    Colors.red
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white24),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                // showAvg ? avgData() : mainData(),
                mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            if (value % 2 == 0) return value.toString() + 'º';
            return '';
          },
          interval: 5.0,
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: getMax(widget.data),
      minY: getMinY(widget.data) - 5,
      maxY: getMaxY(widget.data) + 10,
      lineBarsData: [
        LineChartBarData(
          spots: create_spots(),
          isCurved: false,
          colors: gradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> create_spots() {
    List<FlSpot> output = [];
    for (double i in widget.data.keys) {
      FlSpot newSpot = FlSpot(i, widget.data[i]);
      output.add(newSpot);
    }
    return output;
  }

  getMax(Map<double, double> data) {
    double max = 0;
    for (double i in data.keys) {
      max = i;
    }
    return max;
  }

  getMaxY(Map<double, double> data) {
    double maxV = 0;
    for (double i in data.values) {
      maxV = max(maxV, i);
    }
    return maxV;
  }

  getMinY(Map<double, double> data) {
    double minV = 1000000000;
    for (double i in data.values) {
      minV = min(minV, i);
    }
    return minV;
  }
}
