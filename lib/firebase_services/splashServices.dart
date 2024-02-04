
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/homeScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/welcomeScreen.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user!=null) {
      Timer(const Duration(seconds: 3),
              () =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()))
      );
    } else {
      Timer(const Duration(seconds: 3),
      () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()))
      );
    }
  }
}
