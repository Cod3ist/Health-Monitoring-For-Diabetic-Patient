import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool response;
  const MessageWidget({super.key, required this.text, this.response=false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: response ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: response ? 310 : 130,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: response ? Colors.grey.shade300 : Color.fromARGB(255, 174, 136, 255),
              borderRadius: BorderRadius.circular(8).copyWith(
                  bottomLeft: response ? const Radius.circular(0) : null,
                  bottomRight: !response ? const Radius.circular(0) : null
              )
            ),
            child: Text(
              text,
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: response ? Colors.black54 : Colors.purple.shade50
                )
              )
            ),
          )
        ],
      ),
    );
  }
}
