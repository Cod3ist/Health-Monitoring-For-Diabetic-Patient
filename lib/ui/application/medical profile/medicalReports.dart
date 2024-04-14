import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/medical%20profile/add_medicalReport.dart';
import 'package:hive/hive.dart';

import '../../../utils/fetch_data.dart';

class MedicalReports extends StatefulWidget {
  final String user;
  const MedicalReports({super.key, required this.user});

  @override
  State<MedicalReports> createState() => _MedicalReportsState();
}
class _MedicalReportsState extends State<MedicalReports> {
  String dropDownValue = 'Choose';

  final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(
            'Medical Record',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.deepPurple.shade900
            )
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddReport(user: widget.user,)));
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: getMedicalReports(widget.user),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> map = snapshot.data;
                    print(map);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date:',
                                style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                  )
                                )
                              ),
                              DropdownMenu(
                                hintText: dropDownValue,
                                onSelected: (String? value){
                                  setState(() {
                                    dropDownValue = value!;
                                  });
                                },
                                dropdownMenuEntries: map.keys.toList().map<DropdownMenuEntry<String>>((String e){
                                  return DropdownMenuEntry<String>(value: e, label: e,);
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        if (dropDownValue != 'Choose') ...[
                            Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dropDownValue,
                                    style: GoogleFonts.tiltNeon(
                                      textStyle: TextStyle(
                                          fontSize: 35,
                                          color: Colors.deepPurple[900]
                                      ),
                                    )
                                ),
                                const SizedBox(height: 25,),
                                FastingSugarCard(blood_sugar: double.parse(map[dropDownValue]["Fasting Blood Sugar"])),
                                const SizedBox(height: 25,),
                                GlycosylatedHaemoglobinCard(hba1c:double.parse(map[dropDownValue]["HbA1c"]), eAG:double.parse(map[dropDownValue]["eAG"])),
                                const SizedBox(height: 25,),
                                LipidProfileCard(Cholestrol_total: double.parse(map[dropDownValue]["Cholestrol"]), HDL: double.parse(map[dropDownValue]["HDL"]), LDL: double.parse(map[dropDownValue]["LDL"]), triglycerides: double.parse(map[dropDownValue]["Triglycerides"].toString()),),
                                const SizedBox(height: 25,),
                                EndocronologyCard(T4: double.parse(map[dropDownValue]["T4"]), TSH: double.parse(map[dropDownValue]["TSH"]))
                              ],
                            )
                          )
                        ]
                        else ...[
                          SizedBox(height: 50,),
                          Center(
                            child: Text(
                              'Select a Report to Display',
                              style: GoogleFonts.tiltNeon(
                                textStyle: TextStyle(
                                  fontSize: 40,
                                  color: Colors.grey,
                                )
                              ),
                            ),
                          )
                        ]
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FastingSugarCard extends StatelessWidget {
  final double blood_sugar;
  const FastingSugarCard({super.key, required this.blood_sugar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                  borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))
              ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Test Name',
                        style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                            fontSize:18,
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Results',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )
                        ),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Biological Reference Interval',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:15,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Units',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),

                ]
            ),
            TableRow(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))
                ),
                children: [
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Fasting Blood Sugar',
                          style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                              fontSize: 14
                            )
                          ),
                        ),
                      )
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          blood_sugar.toString(),
                        style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),
                      color: (blood_sugar>75 && blood_sugar<100)
                          ? Colors.green[100]
                          : Colors.red[100]
                      ,
                    )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            '75 - 100',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          ),
                        ),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'mg/dL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          ),
                        ),
                      )
                  )
                ]
            ),
          ],
        ),
      ],
    );
  }
}
class GlycosylatedHaemoglobinCard extends StatelessWidget {
  final double hba1c;
  final double eAG;
  const GlycosylatedHaemoglobinCard({super.key, required this.hba1c, required this.eAG});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glycosylated Haemoglobin (HbA1c)',
            style: GoogleFonts.tiltNeon(
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurple[900]
              ),
            )
        ),
        SizedBox(height: 15,),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Test Name',
                          style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                                fontSize:18,
                                color: Colors.white
                            ),
                          )
                      ),
                    ),
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Results',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )
                        ),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Biological Reference Interval',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:15,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Units',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),

                ]
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Glycosylated Haemoglobin (HbA1c)',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                            '${hba1c} H',
                            style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                    fontSize: 14
                                )
                            )
                        ),
                        color : (hba1c<5.7)
                            ? Colors.green[100]
                            : (hba1c>6.5)
                            ? Colors.red[100]
                            : Colors.yellow[100]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Normal: <5.7\nPrediabetic:5.7-6.4\nDiabetic:>6.5',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '%',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Estimated Average GLUCOSE (eAG)'),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${eAG}'),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(''),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(''),
                    )
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
class LipidProfileCard extends StatelessWidget {
  final double Cholestrol_total;
  final double HDL;
  final double LDL;
  final double triglycerides;
  const LipidProfileCard({super.key, required this.Cholestrol_total, required this.HDL, required this.LDL, required this.triglycerides});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lipid Profile',
            style: GoogleFonts.tiltNeon(
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurple[900]
              ),
            )
        ),
        SizedBox(height: 15,),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Test Name',
                          style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                                fontSize:18,
                                color: Colors.white
                            ),
                          )
                      ),
                    ),
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Results',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )
                        ),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Biological Reference Interval',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:15,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Units',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),

                ]
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100]
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Cholestrol-Total',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '${Cholestrol_total} H',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                      color: (Cholestrol_total<200)
                          ? Colors.green[100]
                          : (Cholestrol_total > 239)
                            ? Colors.red[100]
                            : Colors.yellow[100]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Desirable:<200\nBorderLine:200-239\nHigh:>239',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'mg/dL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[200]
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'HDL Cholestrol',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          HDL.toString(),
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                      color: (HDL<40 || HDL>60)
                          ? Colors.red[100]
                          : Colors.green[100]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Low:<40\nHigh:>60',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'mg/dL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100]
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'LDL Cholestrol',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          LDL.toString(),
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                      color: (LDL<100)
                          ? Colors.green[200]
                          : (LDL<129)
                            ? Colors.green[100]
                            : (LDL<159)
                              ? Colors.yellow[100]
                              : (LDL<189)
                                ? Colors.red[100]
                                : Colors.red[200]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Optimal:<100\nNear Optimal:100-129\nBorderLine: 130-159\nHigh:160-189\nVery High:>190',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'mg/dL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Triglycerides',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${triglycerides}'),
                      color: (triglycerides<150)
                          ? Colors.green[200]
                          : (triglycerides<199)
                            ? Colors.yellow[100]
                            : (triglycerides<499)
                              ? Colors.red[100]
                              : Colors.red[200]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Normal:<150\nHigh:150-199\nHypertriglyceridemic:200-499\nVery High:>499',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'mg/dL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
class EndocronologyCard extends StatelessWidget {
  final double T4;
  final double TSH;
  const EndocronologyCard({super.key, required this.T4, required this.TSH});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Endocrinology',
            style: GoogleFonts.tiltNeon(
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurple[900]
              ),
            )
        ),
        SizedBox(height: 15,),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Test Name',
                          style: GoogleFonts.mukta(
                            textStyle: TextStyle(
                                fontSize:18,
                                color: Colors.white
                            ),
                          )
                      ),
                    ),
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Results',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )
                        ),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Biological Reference Interval',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:15,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Units',
                            style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize:18,
                                  color: Colors.white
                              ),
                            )),
                      )
                  ),

                ]
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100]
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Free T4',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '${T4} L',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                      color: (T4>0.93 && T4<1.7)
                          ? Colors.green[100]
                          : Colors.red[100]
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '0.93 - 1.7',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('mg/dL'),
                    )
                )
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
              ),
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Thyroid Stimulating Hormone',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '${TSH} H',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                      color: (TSH>0.27 && TSH<4.2)
                          ? Colors.green[100]
                          : Colors.red[100]
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '0.27 - 4.2',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                ),
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'ulU/mL',
                          style: GoogleFonts.mukta(
                              textStyle: TextStyle(
                                  fontSize: 14
                              )
                          )
                      ),
                    )
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
