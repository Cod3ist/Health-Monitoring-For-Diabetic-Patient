import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String image_path;
  final bool loading;
  const BoxButton({super.key, required this.title, required this.onTap, this.loading = false, required this.image_path});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade400,
                  Colors.deepPurple.shade200
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Container(
          // width: 120,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  image_path,
                  height: 90,
                  color: Colors.deepPurple.shade100,
                ),
                SizedBox(height: 5,),
                Text(
                    title.toString(),
                    style: GoogleFonts.tiltNeon(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple.shade50
                      )
                    )
                  ),
              ],
            ),
        ),
      ),
    );
  }
}

