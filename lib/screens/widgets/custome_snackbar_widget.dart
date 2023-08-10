import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/constants/const.dart';

class StarGazerCustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const StarGazerCustomSnackBar({
    super.key,
    required this.message,
    this.backgroundColor = Colors.black54,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 1, color: bgColor2),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(milliseconds: 500),
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          message,
          style: GoogleFonts.inconsolata(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
