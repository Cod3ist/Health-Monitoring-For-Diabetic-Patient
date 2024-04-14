import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medical%20profile/medicalReports.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/welcomeScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/fetch_data.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/colors.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  String user;
  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String details = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: getUserDetails(widget.user),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> map = snapshot.data;
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        children: [
                          IntroContainer(name: map["Name"].toString(), BGL: map["Target"].toString()),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (details == 'user') ? Text(
                                'Your Details',
                                style:GoogleFonts.aBeeZee(
                                  textStyle:TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorPalette.deeptextpurple
                                  ),)
                              ) : TextButton(
                                onPressed: (){
                                  setState(() {
                                    details = 'user';
                                  });
                                },
                                child: Text(
                                  'Details',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: ColorPalette.textpurple
                                    ),
                                  )
                                ),
                              ),
                              details == 'medical'? Text(
                                'Medical Details',
                                style:GoogleFonts.aBeeZee(
                                  textStyle:TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.deeptextpurple
                                ),)
                              ) : TextButton(
                                onPressed: (){
                                  setState(() {
                                    details = 'medical';
                                  });
                                },
                                child: Text(
                                  'Medical Details',
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: ColorPalette.textpurple
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: details == 'user'
                                ? PatientDetails(DataMap: map)
                                : MedicalDetails(DataMap: map, user: widget.user),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    );
                } else {
                  return const Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
              }
          ),
        ],
      )
    );
  }
}


class IntroContainer extends StatefulWidget {
  final String name;
  final String BGL;
  const IntroContainer({super.key, required this.name, required this.BGL});

  @override
  State<IntroContainer> createState() => _IntroContainerState();
}
class _IntroContainerState extends State<IntroContainer> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.purple[900],
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular( 20),
            bottomLeft: Radius.circular(20),
        )
      ),
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                alignment: Alignment.topRight,
                onPressed: (){
                  _auth.signOut().then((value){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()
                        )
                    );
                  });
                },
                icon: Icon(
                  Iconsax.logout_1,
                  size: 35,
                  color: Colors.deepPurpleAccent[100],
                )
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child:
            Text(
              'Hey,',
              style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.purple[100]
                ),
              )
            ),
          ),
          Text(
              '${widget.name}!',
              style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurpleAccent[100]
                ),
              )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image(
                image: AssetImage("assets/Images/day.png"),
                height: 80,
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight:FontWeight.w100,
                    color: Colors.deepPurple[100]
                  )
                )
              ),
              SizedBox(width: 60,),
              Image(
                image: AssetImage("assets/Images/currentBGL.png"),
                height: 90,
              ),
              Text(
                  widget.BGL,
                  style: GoogleFonts.tiltNeon(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight:FontWeight.w100,
                        color: Colors.deepPurple[100]
                    )
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PatientDetails extends StatelessWidget {
  final Map<String, dynamic> DataMap;
  const PatientDetails({super.key, required this.DataMap});

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
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  'Patient Details',
                  style: GoogleFonts.tiltNeon(
                    textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[900]
                    ),
                  )
              ),
              const SizedBox(width: 109,),
              IconButton(
                  onPressed: (){
                    // _getMedicalDetails();
                  },
                  icon: Icon(
                      Icons.settings,
                      size: 20,
                      color: Colors.deepPurple[600]
                  )
              ),
            ]
        ),
        Divider(
          height: 10,
          color: Colors.deepPurpleAccent[900],
          thickness: 0.5,
          indent: 10,
          endIndent: 30,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Age:',
                style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                      fontSize:25
                  ),
                )
              ),
              Text(
                _getAge(DataMap["DOB"]).toString(),
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Height:',
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              ),
              Text(
                '${DataMap["Height"]/100}m',
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weight:',
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              ),
              Text(
                '${DataMap["Weight"]}kg',
                style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                      fontSize:25
                  ),
                )
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI:',
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              ),
              Text(
                (DataMap["Weight"]/pow(DataMap["Height"]/100, 2)).toStringAsFixed(2),
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                      fontSize:25
                  ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class MedicalDetails extends StatelessWidget {
  final String user;
  final Map<String, dynamic> DataMap;
  const MedicalDetails({super.key, required this.DataMap, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Medical Profile',
                style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[900]
                  ),
                )
              ),
              const SizedBox(width: 104,),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalReports(user: user,)));
                  },
                  icon: Icon(
                    Icons.event_note_outlined,
                    size: 20,
                    color: Colors.deepPurple[600],
                  )
              ),
            ]
        ),
        Divider(
          height: 10,
          color: Colors.deepPurpleAccent[900],
          thickness: 0.5,
          indent: 10,
          endIndent: 30,
        ),
        Container(
          padding: const EdgeInsets.only(top:10, bottom:15, right: 10, left: 10),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'HbA1c value:',
                      style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                    Text(
                      DataMap["HbA1c"].toString(),
                      style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:10, bottom:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hypercholesterolemia: ',
                      style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                    Text(
                      DataMap["Cholestrol"].toString(),
                      style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:10, bottom:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hyperthyroidism: ',
                      style: GoogleFonts.tiltNeon(
                        textStyle: TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                    Text(
                      DataMap["Thyroid"].toString(),
                      style: GoogleFonts.tiltNeon(
                        textStyle: const TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:10, bottom:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Blood Pressure:',
                      style: GoogleFonts.tiltNeon(
                        textStyle: const TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                    Text(
                      DataMap["Blood Pressure"].toString(),
                      style: GoogleFonts.tiltNeon(
                        textStyle: const TextStyle(
                            fontSize:25
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
