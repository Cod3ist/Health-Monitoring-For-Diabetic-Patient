
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartTiles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class LineChartWidget extends StatelessWidget {
  final String user;
  final String ChartType;
  const LineChartWidget({super.key, required this.user, this.ChartType = 'today'});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ChartType=='today'? fetchData(user) : fetchMonthlyData(user),
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> map = snapshot.data;
            List<ChartData> list =[];
            int index = 0;
            for( var i in map.keys){
              list.add(ChartData(map.keys.toList()[index], map.values.toList()[index].toDouble()));
              index++;
            }
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: [
                LineSeries<ChartData, String>(
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataSource: list,
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
    }
    );
  }
}
