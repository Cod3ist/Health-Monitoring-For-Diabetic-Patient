import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../auth/welcomeScreen.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});
  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final _auth = FirebaseAuth.instance;
  bool _setBreakfast = true;
  bool _setLunch = true;
  bool _setDinner = true;
  final _myBox = Hive.box('SetMenu');
  late Map<String, dynamic> menu;
  late Map<String, dynamic> breakfast;
  late Map<String, dynamic> lunch_dinner;
  late Map<String, dynamic> drink;
  List breakfast_data = [];
  List lunch_data = [];
  List dinner_data = [];

  Future<void> setBreakfast() async {
    final String response = await rootBundle.loadString(
        'assets/data/food.json');
    final data = await json.decode(response) as Map<String, dynamic>;
    setState(() {
      menu = data;
      print(menu["Meal"].length);
      final random = Random();
      breakfast = menu["Breakfast"][random.nextInt(menu["Breakfast"].length)] as Map<String,dynamic>;
      lunch_dinner =menu["Meal"][random.nextInt(menu["Meal"].length)] as Map<String, dynamic>;
      drink = menu["Drink"][random.nextInt(menu["Drink"].length)] as Map<String, dynamic>;
    });
  }

  void refreshBreakfast() async {
    final random = Random();
    setState(() {
      breakfast = menu["Breakfast"][random.nextInt(menu["Breakfast"].length)] as Map<String, dynamic>;
    });
  }

  void refreshMeal() async {
    final random = Random();
    setState(() {
      var index = random.nextInt(menu["Meal"].length);
      lunch_dinner = menu["Meal"][index] as Map<String, dynamic>;
    });
  }

  void refreshDrink() async {
    final random = Random();
    setState(() {
      drink =menu["Drink"][random.nextInt(menu["Drink"].length)] as Map<String, dynamic>;
    });
  }


  void _createMeal(key, value) {
    _myBox.put(key, value);
    print(_myBox.get(key));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBreakfast();
  }

  @override
  Widget build(BuildContext context) {
    if (_myBox.get('Date') != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      _myBox.put('Date', DateFormat('yyyy-MM-dd').format(DateTime.now()));
      print(_myBox.get('Date'));
    } else {
      print(_myBox.keys);
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Meals',
                    style: TextStyle(
                        fontSize: 32
                    ),
                  ),
                ),
                IconButton(
                    alignment: Alignment.bottomRight,
                    onPressed: () {
                      _auth.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()
                            ));
                      });
                    },
                    icon: Icon(
                      Iconsax.logout_1,
                      size: 35,
                      color: Colors.purple,
                    )
                ),
              ],
            ),
            Text(
              'Meal Plan',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 23
              ),
            ),
            Divider(
              thickness: 1,
              indent: 10,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Breakfast',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                _myBox.get('Breakfast') == null && _setBreakfast
                    ? TextButton(
                    onPressed: () {
                      showBreakfastDialog('Breakfast');
                      _myBox.put('Breakfast', breakfast_data);
                      setState(() {
                        breakfast_data.clear();
                        _setBreakfast = false;
                      });
                    },
                    child: Text('Set Menu')
                )
                    : TextButton(
                    onPressed: () {
                      print(_myBox.keys);
                      showMealPlan('Breakfast');
                    },
                    child: Text('View Menu')
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lunch',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                _myBox.get('Lunch') == null && _setLunch
                    ? TextButton(
                    onPressed: () {
                      showMealDialog('Lunch');
                      _myBox.put('Lunch', lunch_data);
                      setState(() {
                        lunch_data.clear();
                        _setLunch = false;
                      });
                    },
                    child: Text('Set Menu')
                )
                    : TextButton(
                    onPressed: () {
                      showMealPlan('Lunch');
                    },
                    child: Text('View Menu')
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dinner',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                _myBox.get('Dinner') == null && _setDinner
                    ? TextButton(
                        onPressed: () {
                          showMealDialog('Dinner');
                          _myBox.put('Dinner', dinner_data);
                          setState(() {
                            dinner_data.clear();
                            _setDinner = false;
                          });
                        },
                        child: Text('Set Menu')
                      )
                    : TextButton(
                        onPressed: () {
                          showMealPlan('Dinner');
                        },
                        child: Text('View Menu')
                      )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // print(_myBox.values);
          _myBox.delete('Breakfast');
          _myBox.delete('Lunch');
          _myBox.delete('Dinner');
        },
      ),
    );
  }

  void showBreakfastDialog(meal) {
    showDialog(
        context: context, // Allow dismissal by tapping outside
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Choose Your dish: ',
              style: TextStyle(
                fontSize: 24
              ),
            ),
            content: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    breakfast["dish"],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Recipe:',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Text(
                    breakfast["recipe"],
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
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
                                    child: Text('Content'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Per Serving (in grams)'),
                                  )
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Carbs'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(breakfast["carbs"].toString()),
                                  )
                              )
                            ]
                        ),
                        TableRow(
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
                                    child: Text(breakfast["protien"].toString()),
                                  )
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Fibre'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(breakfast["fiber"].toString()),
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
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      breakfast_data.add(breakfast);
                    });
                    Navigator.pop(context);
                    showDrinkDialog(meal);
                  },
                  child: Text('Next')
              ),
              TextButton(
                  onPressed: () {
                    refreshBreakfast();
                    Navigator.pop(context);
                    showBreakfastDialog(meal);
                  },
                  child: Text('Refresh')
              ),
            ],
          );
        }
    );
  }
  void showMealDialog(meal) {
    showDialog(
        context: context, // Allow dismissal by tapping outside
        builder: (context) {
          return AlertDialog(
            title: Text('Choose Your dish'),
            content: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    lunch_dinner["dish"],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Recipe:',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    lunch_dinner["recipe"],
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
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
                                    child: Text('Content'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Per Serving (in grams)'),
                                  )
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Carbs'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(lunch_dinner["carbs"].toString()),
                                  )
                              )
                            ]
                        ),
                        TableRow(
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
                                    child: Text(lunch_dinner["protien"].toString()),
                                  )
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Fibre'),
                                  )
                              ),
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(lunch_dinner["fiber"].toString()),
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
            actions: [
              TextButton(
                  onPressed: () {
                    if (meal =='Lunch') {
                      setState(() {
                        lunch_data.add(lunch_dinner);
                      });
                    } else {
                      setState(() {
                        dinner_data.add(lunch_dinner);
                      });
                    }
                    Navigator.pop(context);
                    showDrinkDialog(meal);
                  },
                  child: Text('Next')
              ),
              TextButton(
                  onPressed: () {
                    refreshMeal();
                    Navigator.pop(context);
                    showMealDialog(meal);
                  },
                  child: Text('Refresh')
              ),
            ],
          );
        }
    );
  }
  void showDrinkDialog(meal) {
    showDialog(
        context: context, // Allow dismissal by tapping outside
        builder: (context) {
          return AlertDialog(
            title: Text('Choose Your Drink'),
            content: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    drink["drink"],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'About:',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    drink["description"],
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (meal == 'Breakfast'){
                      setState(() {
                        breakfast_data.add(drink);
                      });
                    } else if (meal == 'Lunch'){
                      setState(() {
                        lunch_data.add(drink);
                      });
                    } else {
                      setState(() {
                        dinner_data.add(drink);
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: Text('Close')
              ),
              TextButton(
                  onPressed: () {
                    refreshDrink();
                    Navigator.pop(context);
                    showDrinkDialog(meal);
                  },
                  child: Text('Refresh')
              ),
            ],
          );
        }
    );
  }
  void showMealPlan(meal){
    var meal_plan = _myBox.get(meal);
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$meal Plan',
                  style: TextStyle(
                    fontSize: 32
                  ),
                ),
                Text(
                  '${meal_plan[0]["dish"]}',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  '${meal_plan[1]["drink"]}',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
}