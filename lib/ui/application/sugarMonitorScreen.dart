import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/addLevel.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartWidget.dart';

class SugarMonitorScreen extends StatefulWidget {
  final String user;
  const SugarMonitorScreen({super.key, required this.user});

  @override
  State<SugarMonitorScreen> createState() => _SugarMonitorScreenState();
}

class _SugarMonitorScreenState extends State<SugarMonitorScreen> {
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
                      onPressed: () {Navigator.of(context).pop();},
                    ),
                  ),
                  Text('Glucose Level', style: TextStyle(fontSize: 30),)
                ],
              ),
              Text('Daily Graph', style: TextStyle(fontSize: 25),),
              LineChartWidget(user: widget.user,),
              Text('30 days Graph', style: TextStyle(fontSize: 25),),
              LineChartWidget(user: widget.user,ChartType: '30Days',),
            ],
          ),
        ),
      ),
    );
  }
}
