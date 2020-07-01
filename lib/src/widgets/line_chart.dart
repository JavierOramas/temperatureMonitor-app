import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartTemperature extends StatefulWidget {
  Map<double,double> data;

  LineChartTemperature({this.data});

  @override
  _LineChartTemperatureState createState() => _LineChartTemperatureState();
}

class _LineChartTemperatureState extends State<LineChartTemperature> {
  List<Color> gradientColors = [
    Colors.orangeAccent,
    Colors.redAccent,
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
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
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
          // child: FlatButton(
          //   onPressed: () {
          //     setState(() {
          //       showAvg = !showAvg;
          //     });
          //   },
          //   child: Text(
          //     'Avg',
          //     style: TextStyle(
          //         fontSize: 12, color: showAvg ? Colors.black12.withOpacity(0.5) : Colors.black),
          //   ),
          // ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      // gridData: FlGridData(

      //   show: true,
      //   drawVerticalLine: true,
      //   getDrawingHorizontalLine: (value) {
      //     return FlLine(
      //       color: Colors.grey,
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingVerticalLine: (value) {
      //     return FlLine(
      //       color: const Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            if(value % 10 == 0 )
              return value.toInt().toString();
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if(value % 10 == 0 )
              return value.toString()+'º';
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: getMax(widget.data),
      minY: getMinY(widget.data)-5,
      maxY: getMaxY(widget.data)+10,
      lineBarsData: [
        LineChartBarData(
          spots: create_spots(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  // LineChartData avgData() {
  //   return LineChartData(
  //     lineTouchData: LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       getDrawingVerticalLine: (value) {
  //         return FlLine(
  //           color: const Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingHorizontalLine: (value) {
  //         return FlLine(
  //           color: const Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: SideTitles(
  //         showTitles: true,
  //         reservedSize: 22,
  //         textStyle:
  //             const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
  //         getTitles: (value) {
  //           switch (value.toInt()) {
  //             case 2:
  //               return 'MAR';
  //             case 5:
  //               return 'JUN';
  //             case 8:
  //               return 'SEP';
  //           }
  //           return '';
  //         },
  //         margin: 8,
  //       ),
  //       leftTitles: SideTitles(
  //         showTitles: true,
  //         textStyle: const TextStyle(
  //           color: Color(0xff67727d),
  //           fontWeight: FontWeight.bold,
  //           fontSize: 15,
  //         ),
  //         getTitles: (value) {
  //           switch (value.toInt()) {
  //             case 1:
  //               return '20°';
  //             case 3:
  //               return '40°';
  //             case 5:
  //               return '60°';
  //           }
  //           return '';
  //         },
  //         reservedSize: 28,
  //         margin: 12,
  //       ),
  //     ),
  //     borderData:
  //         FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
  //     minX: 0,
  //     maxX: getMax(widget.data),
  //     minY: 0,
  //     maxY: 7,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: [
  //           FlSpot(0, 3.44),
  //           FlSpot(2.6, 3.44),
  //           FlSpot(4.9, 3.44),
  //           FlSpot(6.8, 3.44),
  //           FlSpot(8, 3.44),
  //           FlSpot(9.5, 3.44),
  //           FlSpot(11, 3.44),
  //         ],
  //         isCurved: true,
  //         colors: [
  //           ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
  //           ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
  //         ],
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(show: true, colors: [
  //           ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
  //           ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
  //         ]),
  //       ),
  //     ],
  //   );
  // }

  List<FlSpot>create_spots() {
    List<FlSpot> output = [];
    for(double i in widget.data.keys){
      FlSpot newSpot = FlSpot(i,widget.data[i]);
      output.add(newSpot);
    }
    return output;
  }

  getMax(Map<double, double> data) {
    double max = 0;
    for (double i in data.keys){
      max = i;
    }
    return max;
  }

  getMaxY(Map<double, double> data) {
    double maxV = 0;
    for (double i in data.values){
      maxV = max(maxV, i);
    }
    return maxV;
  }

  getMinY(Map<double, double> data) {
    double minV = 1000000000;
    for (double i in data.values){
      minV = min(minV, i);
    }
    return minV;
  }
}