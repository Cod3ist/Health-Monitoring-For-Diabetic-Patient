import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const BoxButton({super.key, required this.title, required this.onTap, this.loading = false});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(107, 72, 14, 200),
                    Color.fromARGB(112, 199, 105, 182)
                  ]
              ),
              borderRadius: BorderRadius.circular(12)
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(13),
              child: Text(
                title.toString(),
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(204, 36, 34, 41)
                ),
              ),
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

