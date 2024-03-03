import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/bloodGlucoseLevel/addLevel.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../widgets/LineChartTiles.dart';

class SugarMonitorScreen extends StatefulWidget {
  final String user;
  const SugarMonitorScreen({super.key, required this.user});

  @override
  State<SugarMonitorScreen> createState() => _SugarMonitorScreenState();
}

class _SugarMonitorScreenState extends State<SugarMonitorScreen> {

  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => AddLevel(user: widget.user,)
          )
         );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 30, 12, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    child: IconButton(
                      icon: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.arrow_back_ios)
                      ),
                      color: Color.fromARGB(139, 168, 121, 255),
                      iconSize:20,
                      onPressed: () {Navigator.pop(context);},
                    ),
                  ),
                  Text('Glucose Level', style: TextStyle(fontSize: 30),)
                ],
              ),
              Text('Daily Graph', style: TextStyle(fontSize: 25),),
              FutureBuilder(
                  future:fetchData(widget.user),
                  builder:(context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      try{
                        Map<String, dynamic> map = snapshot.data;
                        final entries = map.entries.toList();
                        entries.sort((a, b) => a.key.compareTo(b.key));
                        final sortedMap = Map.fromEntries(entries);

                        List<ChartData> list = [];
                        int index = 0;
                        for (var i in sortedMap.keys) {
                          list.add(ChartData(sortedMap.keys.toList()[index],
                              sortedMap.values.toList()[index].toDouble()));
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
                      } catch (e){
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(12),
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
                      return CircularProgressIndicator();
                    }
                  }
              ),
              Text('30 days Graph', style: TextStyle(fontSize: 25),),
              LineChartWidget(user: widget.user,ChartType: '30Days',),
            ],
          ),
        ),
      ),
    );
  }
}
