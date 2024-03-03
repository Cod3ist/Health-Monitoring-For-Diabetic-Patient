import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/navigator/navigator.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/homeScreen.dart';
import 'package:healthcare_monitoring_diabetic_patients/widgets/roundButton.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value) async {
      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu( user: value.user!.uid.toString(),)));
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    child: IconButton(
                      icon: Align(
                        alignment: Alignment.centerLeft,
                          child: Icon(Icons.arrow_back_ios)
                      ),
                      color: Color.fromARGB(139, 168, 121, 255),
                      iconSize:30,
                      onPressed: () {Navigator.of(context).pop();},
                    ),
                  ),
                  Container(
                    height: 270,
                    child: Image(
                        image: AssetImage('assets/Images/Login.jpg'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child:
                      Text(
                          'Login',
                          style: TextStyle(fontSize: 40,)
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              helperText: 'enter email e.g. json@gmail.com',
                              suffix: Icon(
                                Icons.alternate_email_outlined,
                                color: Color.fromARGB(139, 168, 121, 255),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              helperText: 'enter password',
                              suffix: Icon(
                                Icons.password,
                                color: Color.fromARGB(139, 168, 121, 255),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20,),
                      ],
                    )
                  ),
                  RoundButton(
                    title: 'Login',
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        login();
                      }
                    },
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}
