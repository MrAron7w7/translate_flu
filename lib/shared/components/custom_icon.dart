import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final double? iconSize;
  final Color? iconColor;
  final IconData icon;
  const CustomIcon({
    super.key,
    this.iconSize,
    this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: iconSize,
      color: iconColor,
    );
  }
}
