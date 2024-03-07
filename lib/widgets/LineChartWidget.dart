import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartTiles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color color;
}

class LineChartWidget extends StatelessWidget {
  final String user;
  final String ChartType;
  LineChartWidget({super.key, required this.user, this.ChartType = 'today'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12)
      ),
      child: FutureBuilder(
          future: ChartType=='today'? fetchData(user) : fetchMonthlyData(user),
          builder:(context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              try{
                Map<String, dynamic> map = snapshot.data;
                final entries = map.entries.toList();
                entries.sort((a, b) => a.key.compareTo(b.key));
                final sortedMap = Map.fromEntries(entries);
                var targetBGL = sortedMap.remove('Target');
                List<ChartData> list = [];
                int index = 0;
                for (var i in sortedMap.keys) {
                  list.add(ChartData(sortedMap.keys.toList()[index],
                    sortedMap.values.toList()[index],
                    Colors.purple
                  ));
                  index++;
                }
                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    initialVisibleMinimum: 80,
                      plotBands: <PlotBand>[
                        PlotBand(
                            // verticalTextPadding:'5%',
                            // horizontalTextPadding: '5%',
                            textAngle: 0,
                            start: targetBGL,
                            end: targetBGL,
                            textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
                            borderColor: Colors.deepOrange.shade300,
                            borderWidth: 2
                        )
                      ]
                  ),
                  series: [
                    SplineSeries<ChartData, String>(
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      dataSource: list,
                    )
                  ],
                );
              } catch (e){
                return Center(
                  child: Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'No Graph to Display',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.grey
                        ),
                      ),
                    ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}
