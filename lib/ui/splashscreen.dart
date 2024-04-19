import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/firebase_services/splashServices.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromRGBO(238, 179, 231, 1.0),
      body: Center(
        child: Image.asset('assets/Images/SUGAR_AIDE.gif'),
      )
    );
  }
}
