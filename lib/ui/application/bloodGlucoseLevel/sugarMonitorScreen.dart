import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medication/addMedication.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medication/medicationScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/colors.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/utils.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/validate.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/LineChartWidget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../navigator/navigator.dart';
import '../../../utils/fetch_data.dart';

class SugarMonitorScreen extends StatefulWidget {
  final String user;
  const SugarMonitorScreen({super.key, required this.user});

  @override
  State<SugarMonitorScreen> createState() => _SugarMonitorScreenState();
}

class _SugarMonitorScreenState extends State<SugarMonitorScreen> {
  final levelcontroller = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade500, Colors.deepPurple.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        'Day to Day Tracking',
                        style: GoogleFonts.tiltNeon(
                            textStyle: TextStyle(
                                fontSize: 40,
                                color: Colors.deepPurple.shade100,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/Images/notepad.svg',
                      height: 100,
                      color: Colors.deepPurple[200],
                    )
                  ],
                ),
                SizedBox(height: 15),
                BloodSugarLevelContainer(user: widget.user),
                SizedBox(height: 20),
                MedicationContainer(user: widget.user)
              ],
            ),
          ),
      ),
    );
  }
}

class MedicationContainer extends StatelessWidget {
  final String user;
  const MedicationContainer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medications',
                style: GoogleFonts.tiltNeon(
                    textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.deepPurple.shade900
                    )
                ),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewEntryMedicine(user: user,)
                        )
                    );
                  },
                  icon: Icon(
                      Iconsax.add,
                      size: 26,
                      color: Colors.deepPurple.shade900
                  )
              ),
            ],
          ),
          MedicationCardList(user: user)
        ],
      ),
    );
  }
}

class MedicationCardList extends StatefulWidget {
  final String user;
  const MedicationCardList({super.key, required this.user});

  @override
  State<MedicationCardList> createState() => _MedicationCardListState();
}
class _MedicationCardListState extends State<MedicationCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, width: 400,
      child: FutureBuilder(
          future: fetchMedications(widget.user),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              // print(snapshot.data.runtimeType.toString());
              if (snapshot.data.runtimeType.toString() != '_Map<dynamic, dynamic>'){
                Map<String, dynamic> map = snapshot.data;
                List keys = map.values.toList();
                print(keys.runtimeType);
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                  itemCount: keys.length,
                  itemBuilder: (context, index){
                    var _key = map.keys.firstWhere((key) => map[key] == key[index], orElse: () => 'null');
                    return MedicationsList(title: keys[index]['name'], type: keys[index]['type'], description: keys[index], user: widget.user,);
                  },
                  padding: EdgeInsets.all(8),
                );
              } else {
                return Center(
                  child: Text(
                    'No Medications added',
                    style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.grey,
                        )
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


class BloodSugarLevelContainer extends StatefulWidget {
  final String user;
  const BloodSugarLevelContainer({super.key, required this.user});

  @override
  State<BloodSugarLevelContainer> createState() => _BloodSugarLevelContainerState();
}
class _BloodSugarLevelContainerState extends State<BloodSugarLevelContainer> {
  final levelcontroller = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blood Glucose Levels',
                style: GoogleFonts.tiltNeon(
                    textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.deepPurple.shade900
                    )
                ),
              ),
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Blood Glucose Level: '),
                          content: TextField(
                            controller: levelcontroller,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter Value'
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  if (Validate().checkBGLevel(levelcontroller.text)){
                                    Utils().toastMessage(context, 'invalid-level-input');
                                  } else {
                                    database.ref(widget.user).child('Sugar levels').child('Daily').child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()).update({
                                      DateFormat.Hm().format(DateTime.now()).toString() : int.tryParse(levelcontroller.text)
                                    });
                                    database.ref(widget.user)
                                        .child('Sugar levels')
                                        .child('Daily')
                                        .child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
                                        .once().then((event) {
                                      Map<String, dynamic> map = jsonDecode(jsonEncode(event.snapshot.value));
                                      num mean = 0;
                                      for (var value in map.values.toList()){
                                        mean = mean + value;
                                      }
                                      mean = mean / map.values.toList().length;
                                      database.ref(widget.user).child('Sugar levels').child('30Days').update({
                                        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() : mean.round()
                                      });
                                    });
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => NavigationMenu(user: widget.user,)
                                    ));
                                  }
                                },
                                child: Text('Submit')
                            )
                          ],
                        )
                    );
                  },
                  icon: Icon(
                    Iconsax.add,
                    size: 26,
                    color: Colors.deepPurple[900],
                  )
              ),
            ],
          ),
          BloodSugarInfoCard(user: widget.user),
        ],
      ),
    );
  }
}

class BloodSugarInfoCard extends StatefulWidget {
  final String user;
  const BloodSugarInfoCard({super.key, required this.user});

  @override
  State<BloodSugarInfoCard> createState() => _BloodSugarInfoCardState();
}
class _BloodSugarInfoCardState extends State<BloodSugarInfoCard> {
  String graphState = 'today';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            graphState == 'today'? Text(
              'Daily Graph',
              style:  GoogleFonts.mukta(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight:  FontWeight.bold,
                    color: ColorPalette.deeptextpurple
                ),
              ),
            ) : TextButton(
              onPressed: (){
                setState(() {
                  graphState = 'today';
                });
              },
              child: Text(
                'Daily Graph',
                style:  GoogleFonts.mukta(
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: ColorPalette.textpurple
                  ),
                ),
              ),
            ),
            Container( // The vertical divider
              color: ColorPalette.textpurple,
              width: 1.0,
              height: 20 ,
            ),
            graphState == '30Days'? Text(
              'Monthly Graph',
              style:  GoogleFonts.mukta(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight:  FontWeight.bold,
                    color: ColorPalette.deeptextpurple
                ),
              ),
            ) : TextButton(
              onPressed: (){
                setState(() {
                  graphState = '30Days';
                });
              },
              child: Text(
                'Monthly Graph',
                style:  GoogleFonts.mukta(
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: ColorPalette.textpurple
                  ),
                ),
              ),
            ),
          ],
        ),
        LineChartWidget(user: widget.user, ChartType: graphState,),
      ],
    );
  }
}

