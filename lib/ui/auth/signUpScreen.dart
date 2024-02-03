import 'package:flutter/material.dart';

import '../../widgets/roundButton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                SizedBox(height: 100,),
                Container(
                  height: 270,
                  child: Image(
                    image: AssetImage('Images/Login.jpg'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child:
                    Text(
                        'Sign Up',
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
                  title: 'SignUp',
                  onTap: () {
                    if(_formKey.currentState!.validate()){

                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: Container(
                      height: 30,
                      child: Text('Goback'),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
