import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/colors.dart';

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
              color: response ? Colors.grey.shade300 : ColorPalette.purple,
              borderRadius: BorderRadius.circular(8).copyWith(
                  bottomLeft: response ? const Radius.circular(0) : null,
                  bottomRight: !response ? const Radius.circular(0) : null
              )
            ),
            child: Text(
              text
            ),
          )
        ],
      ),
    );
  }
}
