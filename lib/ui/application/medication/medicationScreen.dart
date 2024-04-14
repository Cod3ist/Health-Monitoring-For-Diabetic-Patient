import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medication/syringeMedication.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medication/detailsMedication.dart';

class MedicationsList extends StatefulWidget {
  final String title;
  final String type;
  final Map<String, dynamic> description;
  final String user;
  const MedicationsList({super.key, required this.title, required this.type, required this.description, required this.user, });

  @override
  State<MedicationsList> createState() => _MedicationsListState();
}

class _MedicationsListState extends State<MedicationsList> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: (){
        if (widget.description['type'] == 'Syringe'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SyringeMedicineDetails(user: widget.user, description:widget.description)));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineDetails(description: widget.description, user: widget.user)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple.shade100, borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            SvgPicture.asset(
              widget.description['type'] == 'Syringe'
                ? 'assets/Images/syringe.svg'
                : widget.description['type'] == 'Pill'
                  ? 'assets/Images/tablets.svg'
                  : 'assets/Images/syrup.svg',
              height: 30,
              color: Colors.deepPurple[300],
            ),
            SizedBox(height: 8,),
            Text(
                widget.title,
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                    fontSize: 15
                )
              ),
            ),
            Text(
              widget.type,
              style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      fontSize: 13
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
