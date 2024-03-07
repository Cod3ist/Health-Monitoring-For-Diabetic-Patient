
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/navigator/navigator.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/welcomeScreen.dart';



class SplashServices{
  Future<void> isLogin(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user!=null) {
      // String user_uid = await UIDStorage.getUID().toString();
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  NavigationMenu(user: user.uid,)));
      });
    } else {
      Timer(const Duration(seconds: 3),
      () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()))
      );
    }
  }
}
