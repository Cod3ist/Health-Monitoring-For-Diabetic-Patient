import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/loginScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 70,),
            Container(
              height: 220,
              child: Image(
                image: AssetImage('Images/Welcome.png'),
              ),
            ),
            SizedBox(height: 30,),
            Text('WELCOME!', style: TextStyle(fontSize: 50),),
            SizedBox(height: 20,),
            RoundButton(title: 'SIGN IN', onTap: () =>
            {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => LoginScreen())
              ),
            }),
            SizedBox(height: 20,),
            RoundButton(title: 'SIGN UP', onTap: () => {})
          ],
        ),
      ),
    );
  }
}
