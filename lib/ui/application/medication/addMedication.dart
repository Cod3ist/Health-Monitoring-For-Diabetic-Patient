import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/navigator/navigator.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/fetch_data.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';

class NewEntryMedicine extends StatefulWidget {
  final String user;
  const NewEntryMedicine({super.key, required this.user});

  @override
  State<NewEntryMedicine> createState() => _NewEntryMedicineState();
}

class _NewEntryMedicineState extends State<NewEntryMedicine> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  final notesController = TextEditingController();
  String medicineType = '';
  final _formKey_1 = GlobalKey<FormState>();
  final _formKey_2 = GlobalKey<FormState>();
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(
            'Add Medicine',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoPanel(controller: nameController, title: 'Medicine Name', formKey: _formKey_1,),
            InfoPanel(controller: dosageController, title: 'Dosage',medicineType: medicineType, formKey: _formKey_2,),
            MedicineNotes(controller: notesController,),
            Text(
              'Medicine Type',
              style: GoogleFonts.tiltNeon(
                fontSize: 23,
                color: Colors.deepPurple[900]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MedicineType(
                    type: 'Syrup',
                    isSelected: medicineType == 'Syrup' ? true : false,
                    onTap: () {
                      setState(() {
                        medicineType = 'Syrup';
                      });
                    },
                    path: 'assets/Images/syrup.svg',
                  ),
                  MedicineType(
                    type: 'Pill',
                    isSelected: medicineType == 'Pill' ? true : false,
                    onTap: () {
                      setState(() {
                        medicineType = 'Pill';
                      });
                    },
                    path: 'assets/Images/tablets.svg',
                  ),
                  MedicineType(
                    type: 'Syringe',
                    isSelected: medicineType == 'Syringe' ? true : false,
                    onTap: () {
                      setState(() {
                        medicineType = 'Syringe';
                      });
                    },
                    path: 'assets/Images/syringe.svg',
                  ),
                ],
              ),
            ),
            RoundButton(
                title: 'Confirm',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  if (_formKey_1.currentState!.validate()){
                    if (medicineType != 'Syringe'){
                      var rng = new Random();
                      var code = rng.nextInt(900000) + 100000;
                      if(_formKey_2.currentState!.validate()){
                        database
                            .ref(widget.user)
                            .child('Medical History')
                            .child('Medication')
                            .update({
                          code.toString(): {
                            "name": nameController.text,
                            "dosage": dosageController.text,
                            "type": medicineType,
                            "notes": notesController.text
                          }
                        });
                      } else {
                        database
                            .ref(widget.user)
                            .child('Medical History')
                            .child('Medication')
                            .update({
                          code.toString(): {
                            "name": nameController.text,
                            "type": medicineType,
                            "notes": notesController.text
                          }
                        });
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu(user: widget.user)));
                      setState(() {
                        loading = true;
                      });
                    } else {
                      setState(() {
                        loading = true;
                      });
                    }
                  }
                }
            )
          ],
        ),
      )
    );
  }
}

class InfoPanel extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String medicineType;
  final GlobalKey<FormState> formKey;
  const InfoPanel({super.key, required this.controller, required this.title, this.medicineType = '', required this.formKey});

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}
class _InfoPanelState extends State<InfoPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: widget.formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  widget.title,
                style:GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                    fontSize: 23,
                    color: Colors.deepPurple[900]
                  )
                )
              ),
              TextFormField(
                enabled: widget.medicineType != 'Syringe',
                maxLength: 12,
                decoration: InputDecoration(
                    border: UnderlineInputBorder()
                ),
                textCapitalization: TextCapitalization.words,
                controller: widget.controller,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Details';
                  } else {
                    return null;
                  }
                },
              )
            ],
          ),
      ),
    );
  }
}

class MedicineType extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;
  final String path;
  const MedicineType({super.key, required this.type, required this.isSelected, required this.onTap, required this.path});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                height: 70,
                color: isSelected? Colors.deepPurple[100] : Colors.deepPurple[400],
              ),
              SizedBox(height: 10,),
              Text(
                type,
                style: TextStyle(color: isSelected ? Colors.white54 : Colors.deepPurple[400]),
              ),
            ],
          )
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.deepPurple[400] : Colors.white54
        ),
        height: 120,
        width: 100,
      ),
    );
  }
}

class MedicineNotes extends StatefulWidget {
  final TextEditingController controller;
  const MedicineNotes({super.key, required this.controller,});

  @override
  State<MedicineNotes> createState() => _MedicineNotesState();
}
class _MedicineNotesState extends State<MedicineNotes> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top:10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Notes: ',
              style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                  fontSize: 23,
                  color: Colors.deepPurple[900]
                )
              ),
            ),
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'Add Notes',
                border:UnderlineInputBorder()
              ),
            )
          ],
        ),
      );
  }
}
