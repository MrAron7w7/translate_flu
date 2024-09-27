import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? textSize;
  final TextAlign? textAlign;
  const CustomLabel({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.textSize,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
