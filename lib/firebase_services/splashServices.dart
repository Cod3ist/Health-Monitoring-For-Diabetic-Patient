
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/loginScreen.dart';

class SplashServices{
  void isLogin(BuildContext context){
    Timer(const Duration(seconds: 3),
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }
}
