import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/carbCalculator.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';
import 'package:intl/intl.dart';

import '../../../navigator/navigator.dart';

class SyringeMedicineDetails extends StatefulWidget {
  final String user;
  final Map<String, dynamic> description;
  const SyringeMedicineDetails(
      {super.key, required this.user, required this.description});

  @override
  State<SyringeMedicineDetails> createState() => _SyringeMedicineDetailsState();
}

class _SyringeMedicineDetailsState extends State<SyringeMedicineDetails> {
  final CarbCalculator calculator = CarbCalculator();
  final database = FirebaseDatabase(
      databaseURL:
          "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");
  Map<int, String> ICR = {
    35: '1:35',
    30: '1:30',
    25: '1:25',
    20: '1:20',
    18: '1:18',
    15: '1:15',
    12: '1:12',
    10: '1:10',
    8: '1:8',
    7: '1:7',
    5: '1:5',
    3: '1:3'
  };
  List<int> ISF = [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  int ICRValue = 0;
  int ISFValue = 0;

  Future<void> _deleteMedicine(user, valueToDelete) async {
    final event = await database
        .ref(user)
        .child('Medical History')
        .child('Medication')
        .once();
    dynamic data = event.snapshot.value;

    if (data != null) {
      Map<String, dynamic> values = Map<String, dynamic>.from(data);

      values.forEach((key, value) async {
        if (value["name"] == valueToDelete["name"]) {
          await database
              .ref(user)
              .child('Medical History')
              .child('Medication')
              .child(key)
              .remove()
              .then((_) {
            print('Deleted');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationMenu(
                          user: widget.user,
                        )));
          }).catchError((error) {
            print('Failed to delete: $error');
          });
        }
      });
    }
  }
  Future<dynamic> fetchValues(user) async {
    final event = await database
        .ref(user)
        .child('Patient Details')
        .child('Target')
        .once();
    final event_1 = await database
        .ref(user)
        .child('Sugar levels')
        .child('Daily')
        .child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .once();

    if (event_1 != null && event != null) {
      Map<String, dynamic> map_currentValue =
          jsonDecode(jsonEncode(event_1.snapshot.value));
      var sortedMap = Map.fromEntries(map_currentValue.entries.toList()
        ..sort((e1, e2) => e1.key.compareTo(e2.key)));

      var map_target = jsonDecode(jsonEncode(event.snapshot.value));
      return {'Target': map_target, 'Current': sortedMap[sortedMap.keys.last]};
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final carbController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(
          'Details',
          style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple.shade900
              )
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
                future: fetchValues(widget.user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data.runtimeType);
                    if (snapshot.data.runtimeType.toString() != 'List<dynamic>' && snapshot.hasData) {
                      Map<String, dynamic> map = snapshot.data;
                      return Column(
                        children: [
                          MainSection(currentBGL: map["Current"].toString(),
                              targetBGL: map["Target"].toString()),
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'CarbCalculator',
                              style: GoogleFonts.tiltNeon(
                                  textStyle: TextStyle(
                                      fontSize: 35,
                                      color: Colors.deepPurple[900]
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'ICR value: ',
                                  style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          color: Colors.deepPurple[900]
                                      )
                                  )
                              ),
                              Flexible(
                                child: DropdownMenu<String>(
                                    hintText: (ICRValue == 0)
                                        ? 'Choose'
                                        : ICR[ICRValue].toString(),
                                    onSelected: (String? value) {
                                      setState(() {
                                        ICRValue = int.tryParse(value!)!;
                                      });
                                    },
                                    dropdownMenuEntries: ICR.keys
                                        .toList()
                                        .map<DropdownMenuEntry<String>>((
                                        int e) {
                                      return DropdownMenuEntry(
                                        value: e.toString(),
                                        label: ICR[e].toString(),
                                      );
                                    }).toList()),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'ISF value: ',
                                  style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          color: Colors.deepPurple[900]
                                      )
                                  )
                              ),
                              Flexible(
                                child: DropdownMenu<int>(
                                    hintText: (ISFValue == 0)
                                        ? 'Choose'
                                        : ISFValue.toString(),
                                    onSelected: (int? value) {
                                      setState(() {
                                        ISFValue = value!;
                                      });
                                    },
                                    dropdownMenuEntries:
                                    ISF.map<DropdownMenuEntry<int>>((int e) {
                                      return DropdownMenuEntry(
                                        value: e,
                                        label: e.toString(),
                                      );
                                    }).toList()),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                  'Carb Intake:',
                                  style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          color: Colors.deepPurple[900]
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: carbController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Value'),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 30,),
                          TextButton(
                              onPressed: () {
                                calculator.calculate(map["Target"].toDouble(),
                                    map["Current"].toDouble(), ICRValue,
                                    ISFValue, int.parse(carbController.text));
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: Text(
                                            'Units: ',
                                            style: GoogleFonts.tiltNeon(
                                                fontSize: 30
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(20),
                                          content: Container(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  // '${_calculate(map["Target"], map["Current"], ICRValue, ISFValue, int.tryParse(carbController.text))}',
                                                  '${calculator.result
                                                      .toStringAsFixed(2)}',
                                                  style: GoogleFonts.mukta(
                                                      textStyle: TextStyle(
                                                          fontSize: 25
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 2,),
                                                Text(
                                                    '**recommended to round down to the nearest 0.5 units',
                                                    style: GoogleFonts.mukta(
                                                        fontSize: 15,
                                                        color: Colors.grey
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                );
                              },
                              child: Text(
                                'Calculate',
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              )
                          ),
                          SizedBox(height: 30,),
                          RoundButton(
                            onTap: () {
                              openAlertBox(context);
                            },
                            title: 'Delete',
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Please add your current BGL level',
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
                    return Container();
                  }
                })
          ],
        ),
      ),
    );
  }

  openAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            contentPadding: EdgeInsets.only(top: 10),
            title: Text(
              'Delete This Reminder',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.caption,
                  )),
              TextButton(
                  onPressed: () {
                    _deleteMedicine(widget.user, widget.description);
                  },
                  child: Text(
                    'OK',
                  )),
            ],
          );
        });
  }
}
class MainSection extends StatelessWidget {
  final String currentBGL;
  final String targetBGL;
  const MainSection({super.key, required this.currentBGL, required this.targetBGL,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[Colors.deepPurple.shade700, Colors.deepPurple.shade100]),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10,),
            SvgPicture.asset(
              'assets/Images/syringe.svg',
              color: Colors.deepPurple.shade100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                MainInfoTab(
                  fieldTitle: 'Current BGL',
                  fieldInfo: currentBGL,
                ),
                MainInfoTab(
                  fieldTitle: 'Target BGL',
                  fieldInfo: targetBGL,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;
  const MainInfoTab({super.key, required this.fieldTitle, required this.fieldInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 90,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: GoogleFonts.mukta(
                  fontSize: 20,
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              fieldInfo,
              style: GoogleFonts.mukta(
                  fontSize: 25
              ),
            ),
          ],
        ),
      ),
    );
  }
}