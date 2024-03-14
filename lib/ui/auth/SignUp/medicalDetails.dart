import 'package:flutter/material.dart';

class MedicalDetails extends StatefulWidget {
  final String user;
  const MedicalDetails({super.key, required this.user});

  @override
  State<MedicalDetails> createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  String isCholestrol = "Yes";
  bool isThyroid = true;
  bool isBloodPressure = true;
  final isAllergies = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              'Does the patient have high cholesterol or a history of cholesterol problems?',
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
                        isCholestrol = "Yes";
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
                        isCholestrol = isCholestrol!;

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
                    groupValue: isCholestrol,
                    onChanged: (value) {
                      setState(() {
                        isCholestrol = isCholestrol!;
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
                        isCholestrol = isCholestrol!;

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
                    value: true,
                    groupValue: isCholestrol,
                    onChanged: (value) {
                      setState(() {
                        isCholestrol = isCholestrol!;
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
                        isCholestrol = isCholestrol!;

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
              'Is the patient allergic to any medication?',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            const SizedBox(height: 5,),
            TextField(
              controller: isAllergies,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter details',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                )
              ),
            )
          ]
        ),
      ),
    );
  }
}
