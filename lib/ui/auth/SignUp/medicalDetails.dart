import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/navigator/navigator.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';

class MedicalDetails extends StatefulWidget {
  final String user;
  const MedicalDetails({super.key, required this.user});

  @override
  State<MedicalDetails> createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  bool loading = false;
  String isCholestrol = "";
  String isThyroid = "";
  String isBloodPressure = "";
  String isAllergies = "";
  bool enable = false;
  final allergiesController = TextEditingController();
  final hba1c = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Medical Details',
                style: TextStyle(
                  fontSize: 32
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Do you have high cholesterol or a history of cholesterol problems?',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "Yes",
                      groupValue: isCholestrol,
                      onChanged: (value) {
                        setState(() {
                          isCholestrol = value!;
                        });
                      }
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  const SizedBox(width: 60,),
                  Radio(
                      value: "No",
                      groupValue: isCholestrol,
                      onChanged: (value) {
                        setState(() {
                          isCholestrol = value!;
                        });
                      }
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text(
                'Has the patient been diagnosed with any thyroid conditions?',
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "Yes",
                      groupValue: isThyroid,
                      onChanged: (value) {
                        setState(() {
                          isThyroid = value!;
                        });
                      }
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(width: 60,),
                  Radio(
                      value: "No",
                      groupValue: isThyroid,
                      onChanged: (value) {
                        setState(() {
                          isThyroid = value!;
                        });
                      }
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text(
                'Does the patient suffer from blood pressure?',
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "Yes",
                      groupValue: isBloodPressure,
                      onChanged: (value) {
                        setState(() {
                          isBloodPressure = value!;
                        });
                      }
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(width: 60,),
                  Radio(
                      value: "No",
                      groupValue: isBloodPressure,
                      onChanged: (value) {
                        setState(() {
                          isBloodPressure = value!;
                        });
                      }
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Text(
                'Previous HbA1c value: ',
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              const SizedBox(height: 5,),
              TextField(
                keyboardType: TextInputType.number,
                controller: hba1c,
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
              Text(
                'Is the patient allergic to any medication?',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "Yes",
                      groupValue: isAllergies,
                      onChanged: (value) {
                        setState(() {
                          isAllergies = value!;
                          enable = true;
                        });
                      }
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  const SizedBox(width: 60,),
                  Radio(
                      value: "No",
                      groupValue: isAllergies,
                      onChanged: (value) {
                        setState(() {
                          isAllergies = value!;
                          enable = false;
                        });
                      }
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              TextField(
                enabled: enable,
                keyboardType: TextInputType.number,
                controller: allergiesController,
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
              const SizedBox(height: 30,),
              RoundButton(
                loading: loading,
                  title: 'Submit',
                  onTap: (){
                    setState(() {
                      loading = true;
                    });
                    database.ref(widget.user).child('Medical History').set({
                      'Cholestrol' : isCholestrol,
                      'Thyroid' : isThyroid,
                      'Blood Pressure' : isBloodPressure,
                      'Allegies' : (isAllergies == "Yes") ? allergiesController.text.toString() : isAllergies,
                      'HbA1c' : int.tryParse(hba1c.text)
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu(user: widget.user)));
                    setState(() {
                      loading = false;
                    });
                  }
              )
            ]
          ),
        ),
      ),
    );
  }
}
