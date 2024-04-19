import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/chatbotfetch.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../widgets/chat_list_view.dart';
import '../../auth/welcomeScreen.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<dynamic> conversations = [];
  String url = '';
  var Query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 760,
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleCard(),
              const SizedBox(height: 20,),
              ChatListView(conversations: conversations),
              const SizedBox(height: 20,),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    const SizedBox(width: 16,),
                    Flexible(
                      child: TextField(
                        onChanged: (value){
                          url = 'http://10.0.2.2:5000/api?query=${value.toString()}';
                          setState(() {
                            Query = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ask me anything',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var data = await getResponse(url);
                        var decoded = jsonDecode(data);
                        setState(() {
                          conversations.add({'query':Query, 'response':decoded['output']});
                        });
                      },
                      color: Colors.deepPurple.shade300,
                      icon: Icon(Iconsax.send1),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    ) ;
  }
}

class TitleCard extends StatelessWidget {
  const TitleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            'Chatbot',
            style: GoogleFonts.tiltNeon(
                textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.deepPurple.shade100,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/Images/chatbot_icon.svg',
          height: 100,
          color: Colors.deepPurple[200],
        )
      ],
    );
  }
}
