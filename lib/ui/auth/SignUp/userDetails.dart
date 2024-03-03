
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/homeScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';



Object details = {};
const List<String> list = <String>['Type 1', 'Type 2'];
class RegisterationForm extends StatefulWidget {
  final String user;
  const RegisterationForm({super.key, required this.user});

  @override
  State<RegisterationForm> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<RegisterationForm> {
  int year = 2024;
  int day = 8;
  int month = 2;
  String dropDownValue = 'Choose';
  bool loading = false;
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final targetcontroller = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

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
              Text(' At what age were you diagnosed? ', style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                controller: agecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Age',
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
              Row(
                children: [
                  Text('Which type do you have?', style: TextStyle(fontSize: 18),),
                  SizedBox(width: 12,),
                  DropdownMenu(
                      hintText: 'Choose',
                      onSelected: (String? value){
                        setState(() {
                          dropDownValue = value!;
                        });
                        },
                      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String e){
                        return DropdownMenuEntry<String>(value: e, label: e,);
                      }).toList()
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text('What is the target BGL that you want to achieve? ', style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                controller: targetcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter value',
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
              SizedBox(height: 30,),
              RoundButton(
                loading: loading,
                  title: 'Submit',
                  onTap: (){
                    setState(() {
                      loading = true;
                    });
                    database.ref(widget.user).child('Patient Details').set({
                      'Name':namecontroller.text.toString(),
                      'Age Diagnosed': int.tryParse(agecontroller.text),
                      'DOB' : '$year-$month-$day',
                      'Type' : dropDownValue,
                      'Target' : int.tryParse(targetcontroller.text)
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: widget.user)));
                    setState(() {
                      loading = false;
                    });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}