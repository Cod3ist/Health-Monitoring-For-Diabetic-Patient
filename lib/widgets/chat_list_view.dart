import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/message.dart';

class ChatListView extends StatefulWidget {
  final List<dynamic> conversations;
  const ChatListView({super.key, required this.conversations});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.conversations.isNotEmpty ? ListView.builder(
          itemCount: widget.conversations.length,
          itemBuilder: (context, index){
            var chat = widget.conversations[index];
            return Column(
              children: [
                MessageWidget(text: chat['query']),
                SizedBox(height: 10,),
                MessageWidget(text: chat['response'], response: true),
                SizedBox(height: 10,),
              ],
            );
          }
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Images/chatbot.gif',
            height: 100,
          ),
          Text(
              'Welcome!',
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple.shade900
                )
              )
          ),
          Text(
              'Hello, Im Chatty Cathy!',
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple.shade400
                )
              )
          ),
          Text(
              'Ask me anything',
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple.shade400
                )
              )
          )
        ],
      ),
    );
  }
}
