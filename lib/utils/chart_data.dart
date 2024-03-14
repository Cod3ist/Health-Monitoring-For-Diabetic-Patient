import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

import 'package:intl/intl.dart';

final database= FirebaseDatabase(databaseURL: "https://dummy-4eeab-default-rtdb.asia-southeast1.firebasedatabase.app");

Future<dynamic> fetchData(user) async {
  final event_1 = await database.ref(user).child('Patient Details').child('Target').once();
  final event = await database.ref(user).child('Sugar levels')
      .child('Daily').child(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()).once();
  dynamic snapshotValue = event.snapshot.value;
  if (snapshotValue!=null) {
    Map<String, dynamic> map = jsonDecode(jsonEncode(snapshotValue));
    map["Target"] = event_1.snapshot.value;
    return map;
  } else {
    return [];
  }
}

Future<dynamic> fetchMonthlyData(user) async {
  final event_1 = await database.ref(user).child('Patient Details').child('Target').once();
  final event = await database.ref(user).child('Sugar levels')
      .child('30Days').once();
  dynamic snapshotValue = event.snapshot.value;
  if (snapshotValue!=null) {
    Map<String, dynamic> map = jsonDecode(jsonEncode(event.snapshot.value));
    map["Target"] = event_1.snapshot.value;
    return map;
  } else {
    print(user);
    return [];
  }
}