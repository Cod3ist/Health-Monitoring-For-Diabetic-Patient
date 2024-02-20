import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/nutrition/FoodFacts.dart';
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
    _filteredData = _searchController.text.isEmpty ?
        _allData :  _allData.where((element) =>
            element.item!.toLowerCase().contains(value.toLowerCase())
        ).toList();
    return _filteredData;
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
        title: Text('Nutrition Main Screen'),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NutritionDetails(
                                  item: _filteredData[index].item.toString(),
                                ),
                              ),
                            );
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
