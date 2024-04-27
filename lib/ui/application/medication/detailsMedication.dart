import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';
import '../../../navigator/navigator.dart';

class MedicineDetails extends StatefulWidget {
  final String user;
  final Map<String, dynamic> description;
  const MedicineDetails({super.key, required this.description, required this.user});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  Future<void> _deleteMedicine(user, valueToDelete) async {
    final event = await database.ref(user).child('Medical History').child('Medication').once();
    dynamic data = event.snapshot.value;

    if (data != null) {
      Map<String, dynamic> values = Map<String, dynamic>.from(data);
      print(valueToDelete);

      values.forEach((key, value) async {
        if (value["name"] == valueToDelete["name"]) {
          await database.ref(user).child('Medical History').child('Medication')
              .child(key).remove().then((_) {
            print('Deleted');
            Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu(user: widget.user,)));
          }).catchError((error) {
            print('Failed to delete: $error');
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              MainSection(name: widget.description["name"], dosage: widget.description["dosage"], type: widget.description["type"],),
              ExtendedSection(type: widget.description["type"], notes: widget.description["notes"],),
              Spacer(),
              RoundButton(
                onTap: () {
                  openAlertBox(context);
                },
                title: 'Delete',
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
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
  final String name;
  final String dosage;
  final String type;
  const MainSection({super.key, required this.name, this.dosage ='', required this.type});

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
              type=='Pill'
                  ? 'assets/Images/tablets.svg'
                  : 'assets/Images/syrup.svg',
              color: Colors.deepPurple.shade100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                MainInfoTab(
                  fieldTitle: 'Medicine Name',
                  fieldInfo: name,
                ),
                MainInfoTab(
                  fieldTitle: 'Dosage',
                  fieldInfo: '${dosage}',
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

class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              fieldTitle,
              style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.deepPurple[900]
                )
              ),
            ),
          ),
          Text(
            fieldInfo,
            style: GoogleFonts.mukta(
                textStyle: TextStyle(
                    fontSize: 18,
                )
            ),
          ),
        ],
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  final String type;
  final String notes;
  const ExtendedSection({super.key, required this.type, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ExtendedInfoTab(
          fieldTitle: 'Medicine Type',
          fieldInfo: type,
        ),
        ExtendedInfoTab(
          fieldTitle: 'Dose Interval',
          fieldInfo: notes,
        ),
      ],
    );
  }
}