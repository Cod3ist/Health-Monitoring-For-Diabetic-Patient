import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/foodDataModel.dart';

class NutritionMainScreen extends StatefulWidget {
  const NutritionMainScreen({Key? key}) : super(key: key);

  @override
  State<NutritionMainScreen> createState() => _NutritionMainScreenState();
}

class _NutritionMainScreenState extends State<NutritionMainScreen> {
  late List<FoodDetailsModel> _allData;
  late List<FoodDetailsModel> _filteredData;
  final _searchController = TextEditingController();
  late String value;


  Future<List<FoodDetailsModel>> _fetchData() async {
    _allData = await readJson();
    // print(_allData);
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
                children: [

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
        title: Text('Snacks'),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          TextField(
            controller: _searchController,
            onChanged: (_value){
              setState(() {
                value = _value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Search for food...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
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
                                    title: Text(_filteredData[index].item.toString()),
                                    content: Container(
                                      height: 600,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              _filteredData[index].description.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Text(
                                            ' Nutrition Facts',
                                            style: TextStyle(
                                                fontSize: 17
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
                                                            child: Text(_filteredData[index].gi.toString()),
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
                                                            child: Text(_filteredData[index].carbs.toString()),
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
                                                            child: Text(_filteredData[index].protein.toString()),
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
                                                            child: Text(_filteredData[index].fiber.toString()),
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
                            title: Text(_filteredData[index].item.toString()),
                            subtitle: Text(_filteredData[index].gi.toString()),
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
