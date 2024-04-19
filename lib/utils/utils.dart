import 'package:flutter/material.dart';

class Utils{

  List checkError(String message){
    var error;
    if (message.contains('email-already-in-use')){
      error = ['User Already Exists', 'The email address is already in use.\nPlease use another email address'];
    } else if (message.contains('weak-password')){
      error = ['Weak Password', 'Password should be at least 6 characters'];
    } else if (message.contains('invalid-level-input')){
      error = ['Invalid Input', 'The level value must be greater than 0.\nPlease enter a valid input'];
    } else if (message.contains('invalid-email')){
      error = ['Invalid Email', 'The email address is badly formatted'];
    } else if (message.contains('invalid-credential')){
      error = ['Invalid Credentials', 'The supplied auth credential are incorrect'];
    } else if (message.contains('invalid-user-age')){
      error = ['Invalid Details', 'Incorrect age has been entered'];
    } else if (message.contains('invalid-user-height')){
      error = ['Invalid Details', 'Incorrect height has been entered'];
    } else if (message.contains('invalid-user-weight')){
      error = ['Invalid Details', 'Incorrect weight has been entered'];
    } else if (message.contains('invalid-user-dob')){
      error = ['Invalid Details', 'Incorrect date of birth has been entered'];
    } else if (message.contains('incomplete-form')){
      error = ['Invalid Details', 'Form is missing details.\nPlease make sure all information has been added'];
    };
    return error;
  }
  void toastMessage(BuildContext context, String message){
    List diaply_msg = checkError(message);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(139, 168, 121, 255),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            child: Row(
              children: [
                Container(
                  child: Icon(Icons.error_outline, color: Colors.white,),
                  height: 20,
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diaply_msg[0].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Container(
                      child: Text(
                        diaply_msg[1].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}