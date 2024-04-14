import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/SignUp/medicalDetails.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/utils.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';
import 'package:intl/intl.dart';

import '../../../utils/validate.dart';

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
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final targetcontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

  _formatDate(year, month, day) {
    DateTime date = DateTime(year, month, day);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Details',
                  style: TextStyle(
                      fontSize: 32
                  ),
                ),
                SizedBox(height: 15,),
                Text(' Your Name: ', style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                TextFormField(
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
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Name';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 30,),
                const Text('Date Of Birth:', style: TextStyle(fontSize: 18),),
                const SizedBox(height: 10,),
                DropdownDatePicker(
                  onChangedDay: (value) {
                    setState(() {
                      day = int.tryParse(value!)!;
                    });
                  },
                  onChangedMonth: (value) {
                    setState(() {
                      month = int.tryParse(value!)!;
                    });
                  },
                  onChangedYear: (value) {
                    setState(() {
                      year = int.tryParse(value!)!;
                    });
                  },
                ),
                SizedBox(height: 30,),
                Text(' At what age were you diagnosed? ', style: TextStyle(fontSize: 18),),
                const SizedBox(height: 10,),
                TextFormField(
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Age';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Which type do you have?', style: TextStyle(fontSize: 18),),
                    SizedBox(width: 12,),
                    Flexible(
                      child: DropdownMenu(
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
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Height:  ', style: TextStyle(fontSize: 18),),
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: heightcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Enter value (in cm)',
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(139, 168, 121, 255)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(131, 70, 7, 133)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter Height';
                            }
                            return null;
                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Weight: ', style: TextStyle(fontSize: 18),),
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: weightcontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter value (in cm)',
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
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Weight';
                          }
                          return null;
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text('What is the target BGL that you want to achieve? ', style: TextStyle(fontSize: 18),),
                const SizedBox(height: 10,),
                TextFormField(
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter BGL';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 30,),
                RoundButton(
                    loading: loading,
                    title: 'Next',
                    onTap: (){
                      if (_formKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        if (Validate().checkAge(agecontroller.text)){
                          Utils().toastMessage(context, 'invalid-user-age');
                        } else if (Validate().checkHeight(heightcontroller.text)){
                          Utils().toastMessage(context, 'invalid-user-height');
                        } else if (Validate().checkWeight(weightcontroller.text)){
                          Utils().toastMessage(context, 'invalid-user-weight');
                        } else if (Validate().checkBirthDate(year)){
                          Utils().toastMessage(context, 'invalid-user-dob');
                        }  else if (Validate().checkBGLevel(targetcontroller.text)){
                          Utils().toastMessage(context, 'invalid-level-input');
                        } else if (dropDownValue == 'Choose'){
                          Utils().toastMessage(context, 'incomplete-form');
                        } else {
                          database
                              .ref(widget.user)
                              .child('Patient Details')
                              .set({
                            'Name': namecontroller.text.toString(),
                            'Age Diagnosed': int.tryParse(agecontroller.text),
                            'Height': int.tryParse(heightcontroller.text),
                            'Weight': int.tryParse(weightcontroller.text),
                            'DOB': _formatDate(year, month, day),
                            'Type': dropDownValue,
                            'Target': int.tryParse(targetcontroller.text)
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MedicalDetails(user: widget.user)));
                        }
                        print(widget.user);
                        setState(() {
                          loading = false;
                        });
                      }

                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}