import 'package:flutter/material.dart';

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
        children: [
          Text('data')
        ],
      ),
    );
  }
}
