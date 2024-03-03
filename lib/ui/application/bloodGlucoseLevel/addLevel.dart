
import 'dart:core';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/navigator/navigator.dart';
import 'package:intl/intl.dart';

class AddLevel extends StatefulWidget {
  final String user;
  const AddLevel({super.key, required this.user});

  @override
  State<AddLevel> createState() => _AddLevelState();
}

class _AddLevelState extends State<AddLevel> {
  final levelcontroller = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter value',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: levelcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Value',
                ),
              ),
              SizedBox(height: 10,),
              IconButton(
                onPressed: (){
                  database.ref(widget.user).child('Sugar levels').child('Daily').child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()).update({
                    DateFormat.Hm().format(DateTime.now()).toString() : int.tryParse(levelcontroller.text)
                  });
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => NavigationMenu(user: widget.user,)
                  )
                  );

                  // database.ref(widget.user)
                  //     .child('Sugar levels')
                  //     .child('Daily')
                  //     .child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
                  //     .once().then((event) {
                  //       Map<String, dynamic> map = jsonDecode(jsonEncode(event.snapshot.value));
                  //       print(map.values.toList());
                  // });
                },
                icon: Icon(Icons.add, size: 35,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
