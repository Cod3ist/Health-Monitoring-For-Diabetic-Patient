import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/welcomeScreen.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  final String user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  Future<dynamic> _getUserDetails() async {
    final event = await database.ref(widget.user).child('Patient Details').once();
    Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
    return data;
  }

  _getAge(date) {
    final converted_date = DateTime.parse(date);
    final current_date = DateTime.now();
    final age = current_date.year - converted_date.year;
    final monthDifference = current_date.month - converted_date.month;
    if (monthDifference < 0 || (monthDifference == 0 && current_date.day < converted_date.day)){
      return age-1;
    } else {
      return age;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: _getUserDetails(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> map = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hey, ${map["Name"].toString()}!',
                                style: TextStyle(
                                    fontSize: 32
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
                                    });},
                                  icon: Icon(
                                    Iconsax.logout_1,
                                    size: 35,
                                    color: Colors.purple,
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Patient Details',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(width: 135,),
                              IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    size: 20,
                                  )
                              ),
                            ]
                          ),
                          Divider(
                            height: 10,
                            color: Colors.purple,
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 30,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Age:',
                                  style: TextStyle(
                                    fontSize:20
                                  ),
                                ),
                                Text(
                                  _getAge(map["DOB"]).toString(),
                                  style: TextStyle(
                                    fontSize:20
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Height:',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                                Text(
                                  '${map["Height"]/100}m',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Weight:',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                                Text(
                                  '${map["Weight"]}kg',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BMI:',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                                Text(
                                  (map["Weight"]/pow(map["Height"]/100, 2)).toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Age Diagnosed:',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                                Text(
                                  '${map["Age Diagnosed"]}',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Target BGL:',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                                Text(
                                  '${map["Target"]}',
                                  style: TextStyle(
                                      fontSize:20
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          ),
        ],
      )
    );
  }
}
