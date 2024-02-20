import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';

class FoodDetailsModel{
  String? item;
  double? gi;
  double? carbs;
  double? protein;
  double? fiber;
  String? description;

  FoodDetailsModel(
      {
        this.item,
        this.gi,
        this.carbs,
        this.protein,
        this.fiber,
        this.description
      }
  );

  FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    gi = json['Glycemic Index'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    fiber = json['Fiber'];
    description = json['Description'];
  }

}

Future<List<FoodDetailsModel>> readJson() async {
  final response = await rootBundle.loadString('assets/data/food.json');
  final data = json.decode(response) as List<dynamic>;
  print(data);
  return data.map((e) => FoodDetailsModel.fromJson(e)).toList();
}