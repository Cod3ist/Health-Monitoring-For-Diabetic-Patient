import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/foodDataModel.dart';

class NutritionDetails extends StatelessWidget {
  final String item;
  const NutritionDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return CircularProgressIndicator();
          } else if(snapshot.hasData){
            var data = snapshot.data?.firstWhere((element) => element.item == item);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    data!.item.toString(),
                    style: TextStyle(
                        fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    data.description.toString(),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  ' Nutrition Facts',
                  style: TextStyle(
                      fontSize: 27
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 188, 250)
                        ),
                        children: [
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Title 1'),
                              )
                          ),
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Title 2'),
                              )
                          )
                        ]
                      ),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Glycemic Index'),
                                )
                            ),
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(data.gi.toString()),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Carbohydrates'),
                                )
                            ),
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(data.carbs.toString()),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Protien'),
                                )
                            ),
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(data.protein.toString()),
                                )
                            )
                          ]
                      ),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Fiber'),
                                )
                            ),
                            TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(data.fiber.toString()),
                                )
                            )
                          ]
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
