import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(126, 72, 14, 200),
            borderRadius: BorderRadius.circular(30)
        ),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ),
    );
  }
}
