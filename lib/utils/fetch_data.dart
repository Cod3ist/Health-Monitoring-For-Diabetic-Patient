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

Future<dynamic> getUserDetails(user) async {
  final event_user = await database.ref(user).child('Patient Details').once();
  final event_medical = await database.ref(user).child('Medical History').once();
  Map<String, dynamic> event_user_data = jsonDecode(jsonEncode(event_user.snapshot.value));
  Map<String, dynamic> event_medical_data = jsonDecode(jsonEncode(event_medical.snapshot.value));
  event_user_data.addAll(event_medical_data);
  return event_user_data;
}

Future<dynamic> getMedicalReports(user) async {
  final event = await database.ref(user).child('Medical History').child('Medical Reports').once();
  Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
  return data;
}

Future<dynamic> fetchMedications(user) async {
  final event = await database.ref(user).child('Medical History').child('Medication').once();
  dynamic data = event.snapshot.value;
  if (data != null){
    Map<String, dynamic> map = jsonDecode(jsonEncode(data));
    return map;
  } else {
    return {};
  }
}

