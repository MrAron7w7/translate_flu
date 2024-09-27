import 'package:flutter/material.dart';
import 'package:translate_app/shared/components/components.dart';

class CustomElevatedbutton extends StatelessWidget {
  final Size size;
  final void Function()? onPressed;
  final String text;
  final double? textSize;
  final FontWeight? fontWeight;
  const CustomElevatedbutton({
    super.key,
    required this.size,
    this.onPressed,
    required this.text,
    this.textSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        minimumSize: Size(size.width, 50),
      ),
      child: CustomLabel(
        text: text,
        textSize: textSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
