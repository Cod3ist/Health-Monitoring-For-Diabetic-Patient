import 'package:flutter/material.dart';

class Utils{

  List checkError(String message){
    var error;
    if (message.contains('email-already-in-use')){
      error = ['User Already Exists', 'The email address is already in use by another account.\nPlease use another email address'];
    } else if (message.contains('weak-password')){
      error = ['Weak Password', 'Password should be at least 6 characters'];
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
                    Text(
                      diaply_msg[1].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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