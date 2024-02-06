import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/auth/welcomeScreen.dart';

import '../../widgets/boxButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('HomePage'),
        actions: [
          IconButton(
              onPressed: (){
                _auth.signOut().then((value){Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));});
              },
              icon: Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            BoxButton(title: 'Sug-o-Meter', onTap: (){},),
            SizedBox(height: 10,),
            BoxButton(title: 'Exercise', onTap: (){},),
            SizedBox(height: 10,),
            BoxButton(title: 'Nutrition', onTap: (){},),
            SizedBox(height: 10,),
            BoxButton(title: 'Chatbot', onTap: (){},),
          ],
        ),
      ),
    );
  }
}
