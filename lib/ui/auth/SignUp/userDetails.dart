
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Object details = {};

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  int year = 2024;
  int day = 8;
  int month = 2;
  final namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 55, 15, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(' Your Name: ', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.text,
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(139, 168, 121, 255)
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(131, 70, 7, 133)
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              const Text('Date Of Birth:', style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              DropdownDatePicker(
                onChangedDay: (value) {
                  setState(() {
                    day = value as int;
                  });
                },
                onChangedMonth: (value) {
                  setState(() {
                    month = value as int;
                  });
                },
                onChangedYear: (value) {
                  setState(() {
                    year = value as int;
                  });
                },
              ),
              SizedBox(height: 30,),
              Text(' When were you diagnosed? ', style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
