import 'package:flutter/material.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/shared/components/components.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String image;
  final Color? boxColor;
  final void Function()? onTap;
  const CustomCard({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.textAlign,
    required this.image,
    this.onTap,
    this.boxColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            children: [
              gapW(10),
              // Imagen
              Container(
                width: 35,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(image),
                  ),
                ),
              ),
              gapW(10),
              // nombre
              CustomLabel(
                text: text,
                textColor: textColor,
                textSize: textSize,
                fontWeight: fontWeight,
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
