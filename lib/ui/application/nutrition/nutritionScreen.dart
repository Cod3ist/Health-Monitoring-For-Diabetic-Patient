import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/exercise/exercises.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/nutrition/snackReference.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../widgets/boxButton.dart';
import '../../../widgets/roundButton.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key, });
  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  bool _setBreakfast = true;
  bool _setLunch = true;
  bool _setDinner = true;
  final _myBox = Hive.box('SetMenu');
  late Map<String, dynamic> menu;
  late Map<String, dynamic> breakfast;
  late Map<String, dynamic> lunch_dinner;
  late Map<String, dynamic> drink;

  Future<void> setMeal() async {
    final String response = await rootBundle.loadString(
        'assets/data/food.json');
    final data = await json.decode(response) as Map<String, dynamic>;
    final random = Random();
    setState(() {
      menu = data;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMeal();
    if (_myBox.get('Date') != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      _myBox.clear();
      _myBox.put('Date', DateFormat('yyyy-MM-dd').format(DateTime.now()));
      print(_myBox.get('Date'));
    } else {
      print(_myBox.get('Breakfast'));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple.shade500, Colors.deepPurple.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Column(
          children: [
            TitleCard(),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal Plan',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.tiltNeon(
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.deepPurple.shade900
                      )
                    )
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 20,
                    color: Colors.deepPurple.shade100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breakfast',
                          style: GoogleFonts.tiltNeon(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.deepPurple.shade900
                              )
                          )
                      ),
                      _myBox.get('Breakfast') == null && _setBreakfast
                          ? TextButton(
                              onPressed: () {
                                showBreakfastDialog('Breakfast');
                                setState(() {
                                  _setBreakfast = false;
                                });
                              },
                              child: Text(
                                'Set Menu',
                                style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.deepPurpleAccent.shade100
                                  )
                                )
                              )
                            )
                          : TextButton(
                              onPressed: () {
                                showMealPlan('Breakfast');
                              },
                              child: Text(
                                'View Menu',
                                  style: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.deepPurpleAccent.shade100
                                      )
                                  )
                              )
                            )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lunch',
                          style: GoogleFonts.tiltNeon(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w200,
                              color: Colors.deepPurple.shade900
                            )
                          )
                      ),
                      _myBox.get('Lunch') == null && _setLunch
                          ? TextButton(
                          onPressed: () {
                            showMealDialog('Lunch');
                            setState(() {
                              _setLunch = false;
                            });
                          },
                          child: Text(
                            'Set Menu',
                              style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepPurpleAccent.shade100
                                )
                              )
                          )
                        )
                          : TextButton(
                          onPressed: () {
                            showMealPlan('Lunch');
                          },
                          child: Text(
                              'View Menu',
                              style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.deepPurpleAccent.shade100
                                )
                              )
                          )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dinner',
                        style: GoogleFonts.tiltNeon(
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.deepPurple.shade900
                          )
                        )
                      ),
                      _myBox.get('Dinner') == null && _setDinner
                          ? TextButton(
                              onPressed: () {
                                showMealDialog('Dinner');
                                setState(() {
                                  _setDinner = false;
                                });
                              },
                              child: Text(
                                'Set Menu',
                                style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepPurpleAccent.shade100
                                  )
                                )
                              )
                            )
                          : TextButton(
                              onPressed: () {
                                showMealPlan('Dinner');
                              },
                              child: Text(
                                'View Menu',
                                style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepPurpleAccent.shade100
                                  )
                                )
                              )
                            )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxButton(
                    title: 'Snacks',
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SnackReference()));
                    }, image_path: 'assets/Images/snacks.svg',
                ),
                // SizedBox(height: 10,),
                BoxButton(
                  title: 'Exercise',
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Exercises()));
                  },
                  image_path: 'assets/Images/exercise.svg',
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     _myBox.delete('Breakfast');
      //     _myBox.delete('Lunch');
      //     _myBox.delete('Dinner');
      //   },
      // ),
    );
  }

  void showBreakfastDialog(meal) {
    showDialog(
        context: context, // Allow dismissal by tapping outside
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Choose Your dish: ',
              style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.deepPurple.shade900
                )
              ),
            ),
            content: Container(
              height: 900,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      breakfast["dish"],
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple.shade600
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Image.asset(breakfast["image_path"]),
                    SizedBox(height: 10,),
                    Text(
                      'Recipe:',
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 18,
                            color: Colors.deepPurple.shade800
                          )
                      ),
                    ),
                    Text(
                      breakfast["recipe"],
                      style:  GoogleFonts.mukta(
                          textStyle: TextStyle(
                            fontSize: 16,
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 188, 250)
                              ),
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Content',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Per Serving (in grams)',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Carbs',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          breakfast["carbs"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Protien',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          breakfast["protien"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Fibre',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          breakfast["fiber"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
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
            actions: [
              TextButton(
                  onPressed: () {
                    refreshBreakfast();
                    setState(() {
                      _setBreakfast = false;
                    });
                    Navigator.pop(context);
                    showBreakfastDialog(meal);
                  },
                  child: Text(
                    "Anythin' else?",
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
              ),
              TextButton(
                  onPressed: () {
                    // setState(() {
                    //   breakfast_data.add(breakfast);
                    // });
                    Navigator.pop(context);
                    showDrinkDialog(meal, breakfast);
                  },
                  child: Text(
                    'Looks Good!',
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
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
            title: Text(
                'Choose Your dish',
              style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.deepPurple.shade900
                  )
              ),
            ),
            content: Container(
              height: 900,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      lunch_dinner["dish"],
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple.shade600
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Image.asset(lunch_dinner["image_path"]),
                    SizedBox(height: 10,),
                    Text(
                      'Recipe:',
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurple.shade800
                          )
                      ),
                    ),
                    Text(
                      lunch_dinner["recipe"],
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple.shade600
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 188, 250)
                              ),
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Content',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Per Serving (in grams)',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Carbs',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          lunch_dinner["carbs"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Protien',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          lunch_dinner["protien"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          'Fibre',
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          lunch_dinner["fiber"].toString(),
                                        style: GoogleFonts.mukta(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
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
            actions: [
              TextButton(
                  onPressed: () {
                    refreshMeal();
                    Navigator.pop(context);
                    showMealDialog(meal);
                  },
                  child: Text(
                    "Anythin' else?",
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDrinkDialog(meal, lunch_dinner);
                  },
                  child: Text(
                    'Looks Good!',
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
              ),
            ],
          );
        }
    );
  }
  void showDrinkDialog(meal, item) {
    showDialog(
        context: context, // Allow dismissal by tapping outside
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Choose Your Drink',
              style: GoogleFonts.tiltNeon(
                  textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.deepPurple.shade900
                  )
              ),
            ),
            content: Container(
              height: 900,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      drink["drink"],
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple.shade600
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Image.asset(drink["image_path"]),
                    SizedBox(height: 10,),
                    Text(
                      'About:',
                      style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurple.shade800
                          )
                      ),
                    ),
                    Text(
                      drink["description"],
                      style:  GoogleFonts.mukta(
                          textStyle: TextStyle(
                            fontSize: 16,
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    refreshDrink();
                    Navigator.pop(context);
                    showDrinkDialog(meal, item);
                  },
                  child: Text(
                    "Anythin' else?",
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
              ),
              TextButton(
                  onPressed: () {
                    if (meal == 'Breakfast'){
                      setState(() {
                        // breakfast_data.add([item, drink]);
                        _setBreakfast = false;
                      });
                      _myBox.put('Breakfast', [item, drink]);
                    } else if (meal == 'Lunch'){
                      setState(() {
                        // lunch_data.add(drink);
                        _setLunch = false;
                      });
                      _myBox.put('Lunch', [item, drink]);
                    } else {
                      setState(() {
                        // dinner_data.add(drink);
                        _setDinner = false;
                      });
                      _myBox.put('Dinner', [item, drink]);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Looks Good!',
                    style: GoogleFonts.mukta(
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  )
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
        backgroundColor: Colors.deepPurple.shade50,
        builder: (context) {
          return Container(
            height: 290,
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$meal Plan',
                      style: GoogleFonts.tiltNeon(
                          textStyle: TextStyle(
                              fontSize: 32,
                              color: Colors.deepPurple.shade700
                          )
                      ),
                    ),
                    SvgPicture.asset(
                        (meal == 'Breakfast')
                            ? 'assets/Images/breakfast.svg'
                            : 'assets/Images/lunch_dinner.svg',
                      height: 50,
                      color: Colors.deepPurple.shade400,
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  'Your Dish:',
                  style: GoogleFonts.mukta(
                      textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple.shade700
                      )
                  ),
                ),
                Text(
                  '${meal_plan[0]["dish"]}',
                  style: GoogleFonts.mukta(
                      textStyle: TextStyle(
                          fontSize: 18,
                      )
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 10,),
                Text(
                  'Your Drink:',
                  style: GoogleFonts.mukta(
                      textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple.shade700
                      )
                  ),
                ),
                Text(
                  '${meal_plan[1]["drink"]}',
                  style: GoogleFonts.mukta(
                      textStyle: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          );
        }
    );
  }
}

class TitleCard extends StatelessWidget {
  const TitleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            'Health and Fitness',
            style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.deepPurple.shade100,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/Images/fitness.svg',
          height: 100,
          color: Colors.deepPurple[200],
        )
      ],
    );
  }
}
