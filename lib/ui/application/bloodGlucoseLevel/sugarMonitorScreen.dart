import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartWidget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../navigator/navigator.dart';
import '../../../widgets/LineChartTiles.dart';
import '../../auth/welcomeScreen.dart';

class SugarMonitorScreen extends StatefulWidget {
  final String user;
  const SugarMonitorScreen({super.key, required this.user});

  @override
  State<SugarMonitorScreen> createState() => _SugarMonitorScreenState();
}

class _SugarMonitorScreenState extends State<SugarMonitorScreen> {
  final levelcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String graphState = 'today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Day to Day Tracking',
                      style: TextStyle(
                          fontSize: 32
                      ),
                    ),
                  ),
                  IconButton(
                      alignment: Alignment.bottomRight,
                      onPressed: (){
                        _auth.signOut().then((value){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()
                              ));
                        });
                      },
                      icon: Icon(
                        Iconsax.logout_1,
                        size: 35,
                        color: Colors.purple,
                      )
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Blood Glucose Levels',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: (){}, 
                      icon: Icon(
                          Iconsax.alarm,
                          size: 20
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  graphState == 'today'? Text(
                    'Daily Graph',
                    style:TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ) : TextButton(
                    onPressed: (){
                      setState(() {
                        graphState = 'today';
                      });
                    },
                    child: Text('Daily Graph'),
                  ),
                  Container( // The vertical divider
                    color: Colors.purple,
                    width: 1.0,
                    height: 20 ,
                  ),
                  graphState == '30Days'? Text(
                    'Monthly Graph',
                    style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ) : TextButton(
                    onPressed: (){
                      setState(() {
                        graphState = '30Days';
                      });
                    },
                    child: Text('Monthly Graph'),
                  ),
                ],
              ),
              LineChartWidget(user: widget.user, ChartType: graphState,),
              SizedBox(height: 20),
              Text(
                'Insulin Dosage',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Blood Glucose Level: '),
                              content: TextField(
                                controller: levelcontroller,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: 'Enter Value'
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      database.ref(widget.user).child('Sugar levels').child('Daily').child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()).update({
                                        DateFormat.Hm().format(DateTime.now()).toString() : int.tryParse(levelcontroller.text)
                                      });
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => NavigationMenu(user: widget.user,)
                                      ));
                                    },
                                    child: Text('Submit')
                                )
                              ],
                            )
                        );
                      },
                      child: Text('Add Level')
                  ),
                  TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Blood Glucose Level: '),
                              content: TextField(
                                controller: levelcontroller,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: 'Enter Value'
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      database.ref(widget.user)
                                          .child('Sugar levels').child('Daily')
                                          .child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()).update({
                                        DateFormat.Hm().format(DateTime.now()).toString() : int.tryParse(levelcontroller.text)
                                      });
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => NavigationMenu(user: widget.user,)
                                      ));
                                    },
                                    child: Text('Submit')
                                )
                              ],
                            )
                        );
                      },
                      child: Text('Insulin Calculation')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
