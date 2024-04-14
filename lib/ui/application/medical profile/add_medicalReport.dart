import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medical%20profile/medicalReports.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';
import 'package:intl/intl.dart';

class AddReport extends StatefulWidget {
  final String user;
  const AddReport({super.key, required this.user});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  int year = 2024;
  int day = 08;
  int month = 02;
  final fastingBloodSugar = TextEditingController();
  final HbA1c = TextEditingController();
  final eAG = TextEditingController();
  final cholestrol = TextEditingController();
  final HDLCholestrol = TextEditingController();
  final LDLCholestrol = TextEditingController();
  final Triglycerides = TextEditingController();
  final T4 = TextEditingController();
  final TSH = TextEditingController();
  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");
  final _formKey = GlobalKey<FormState>();

  _formatDate(year, month, day) {
    DateTime date = DateTime(year, month, day);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(
              'Add Report',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reported on:',
                            style: GoogleFonts.tiltNeon(
                              textStyle: TextStyle(
                                fontSize:25,
                                color: Colors.deepPurple[900]
                              )
                            ),
                          ),
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
                          const SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fasting Blood Sugar: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: fastingBloodSugar,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('mg/dL')
                            ],
                          ),
                          const SizedBox(height: 25,),
                          Text(
                            'Glycosylated Haemoglobin (HbA1c)',
                            style: GoogleFonts.tiltNeon(
                                textStyle: TextStyle(
                                    fontSize:25,
                                    color: Colors.deepPurple[900]
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Glycosylated Haemoglobin (HbA1c): '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: HbA1c,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Estimated Average GLUCOSE (eAG): '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: eAG,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          const SizedBox(height: 25,),
                          Text(
                            'Lipid Profile',
                            style: GoogleFonts.tiltNeon(
                                textStyle: TextStyle(
                                    fontSize:25,
                                    color: Colors.deepPurple[900]
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Cholestrol-Total: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: cholestrol,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'HDL Cholestrol: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: HDLCholestrol,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'LDL Cholestrol: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: LDLCholestrol,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Triglycerides: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: Triglycerides,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          const SizedBox(height: 25,),
                          Text(
                            'Endocrinology',
                            style: GoogleFonts.tiltNeon(
                                textStyle: TextStyle(
                                    fontSize:25,
                                    color: Colors.deepPurple[900]
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Free T4: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: T4,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Thyroid Stimulating Hormone: '
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: TSH,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Value'
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Enter value';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Text('H')
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 25,),
                  RoundButton(title: 'Upload', onTap: () {
                    if (_formKey.currentState!.validate()){
                      database.ref(widget.user).child('Medical History').child('Medical Reports').update({
                        _formatDate(year, month, day) : {
                          "Fasting Blood Sugar" : fastingBloodSugar.text,
                          "HbA1c": HbA1c.text,
                          "eAG": eAG.text,
                          "Cholestrol": cholestrol.text,
                          "Triglceri": Triglycerides.text,
                          "HDL":HDLCholestrol.text,
                          "LDL":LDLCholestrol.text,
                          "T4": T4.text,
                          "TSH": TSH.text
                        }
                      });
                      Navigator.pop(context);
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalReports(user: widget.user)));
                  },)
                ],
              ),
          ),
        ),
      ),
    );
  }
}
