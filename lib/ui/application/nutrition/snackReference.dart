import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/foodDataModel.dart';

class SnackReference extends StatefulWidget {
  const SnackReference({Key? key}) : super(key: key);

  @override
  State<SnackReference> createState() => _SnackReferenceState();
}

class _SnackReferenceState extends State<SnackReference> {
  late List<FoodDetailsModel> _allData;
  late List<FoodDetailsModel> _filteredData;
  final _searchController = TextEditingController();
  late String value;


  Future<List<FoodDetailsModel>> _fetchData() async {
    _allData = await readJson();
    _filteredData = _searchController.text.isEmpty ?
        _allData :  _allData.where((element) =>
            element.item!.toLowerCase().contains(value.toLowerCase())
        ).toList();
    return _filteredData;
  }

  void showContext(item){
    showDialog(
        context: context,
        builder: (context) => FutureBuilder(
          future: readJson(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return CircularProgressIndicator();
            } else if(snapshot.hasData){
              var data = snapshot.data?.firstWhere((element) => element.item == item);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:   [

                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(
            'Snacks',
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _searchController,
              onChanged: (_value){
                setState(() {
                  value = _value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.deepPurple.shade50,
                labelText: 'Search',
                hintText: 'Search for food...',
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade100,
                  ),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FoodDetailsModel>>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text(
                                        _filteredData[index].item.toString(),
                                      style: GoogleFonts.tiltNeon(
                                        textStyle: TextStyle(
                                          color: _filteredData[index].gi! < 55.0
                                              ? Colors.green.shade700
                                              : _filteredData[index].gi! <= 69.0
                                              ? Colors.yellow.shade700
                                              : Colors.red.shade700
                                        )
                                      ),
                                    ),
                                    backgroundColor: _filteredData[index].gi! < 55.0
                                          ? Colors.green.shade50
                                          : _filteredData[index].gi! <= 69.0
                                            ? Colors.yellow.shade50
                                            : Colors.red.shade50,
                                    content: Container(
                                      height: 600,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                _filteredData[index].gi! < 55.0
                                                    ? '**Low Glycemic Index'
                                                    : _filteredData[index].gi! <= 69.0
                                                    ? '**Medium Glycemic Index'
                                                    : '**High Glycemic Index',
                                              style: GoogleFonts.mukta(
                                                textStyle: TextStyle(
                                                  color: _filteredData[index].gi! < 55.0
                                                      ? Colors.green.shade800
                                                      : _filteredData[index].gi! <= 69.0
                                                      ? Colors.yellow.shade800
                                                      : Colors.red.shade800,
                                                  fontSize:16
                                                )
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Image.asset(
                                              _filteredData[index].image_path.toString()
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                _filteredData[index].description.toString(),
                                                style: GoogleFonts.mukta(
                                                    textStyle: TextStyle(
                                                        fontSize:15
                                                    )
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                              ' Nutrition Facts',
                                              style: GoogleFonts.tiltNeon(
                                                  textStyle: TextStyle(
                                                      color: _filteredData[index].gi! < 55.0
                                                          ? Colors.green.shade700
                                                          : _filteredData[index].gi! <= 69.0
                                                          ? Colors.yellow.shade700
                                                          : Colors.red.shade700,
                                                    fontSize: 18
                                                  )
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Table(
                                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                children: [
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: _filteredData[index].gi! < 55.0
                                                              ? Colors.green.shade300
                                                              : _filteredData[index].gi! <= 69.0
                                                              ? Colors.yellow.shade300
                                                              : Colors.red.shade300
                                                      ),
                                                      children: [
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Content',
                                                                style: GoogleFonts.mukta(
                                                                  textStyle: TextStyle(
                                                                    fontSize:17
                                                                  )
                                                                )
                                                              ),
                                                            )
                                                        ),
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Per 100 grams',
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:17
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: _filteredData[index].gi! < 55.0
                                                              ? Colors.green.shade100
                                                              : _filteredData[index].gi! <= 69.0
                                                              ? Colors.yellow.shade100
                                                              : Colors.red.shade100
                                                      ),
                                                      children: [
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Glycemic Index',
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  _filteredData[index].gi.toString(),
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: _filteredData[index].gi! < 55.0
                                                              ? Colors.green.shade50
                                                              : _filteredData[index].gi! <= 69.0
                                                              ? Colors.yellow.shade50
                                                              : Colors.red.shade50
                                                      ),
                                                      children: [
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Carbohydrates',
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  _filteredData[index].carbs.toString(),
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: _filteredData[index].gi! < 55.0
                                                              ? Colors.green.shade100
                                                              : _filteredData[index].gi! <= 69.0
                                                              ? Colors.yellow.shade100
                                                              : Colors.red.shade100
                                                      ),
                                                      children: [
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Protien',
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  _filteredData[index].protein.toString(),
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                          color: _filteredData[index].gi! < 55.0
                                                              ? Colors.green.shade50
                                                              : _filteredData[index].gi! <= 69.0
                                                              ? Colors.yellow.shade50
                                                              : Colors.red.shade50
                                                      ),
                                                      children: [
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Fiber',
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                        ),
                                                        TableCell(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  _filteredData[index].fiber.toString(),
                                                                  style: GoogleFonts.mukta(
                                                                      textStyle: TextStyle(
                                                                          fontSize:15
                                                                      )
                                                                  )
                                                              ),
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => NutritionDetails(
                            //       item: _filteredData[index].item.toString(),
                            //     ),
                            //   ),
                            // );
                          },
                          child: ListTile(
                            leading: Image.asset(
                              _filteredData[index].image_path.toString(),
                              height: 40,
                            ),
                            tileColor: Colors.deepPurple.shade50,
                            title: Text(
                                _filteredData[index].item.toString(),
                              style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                  fontSize: 16
                                )
                              ),
                            ),
                            subtitle: Text(
                                _filteredData[index].gi.toString(),
                              style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                      fontSize: 14
                                  )
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
