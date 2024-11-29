import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final String? fontFamily;
  final bool isUnderlined;
  final TextAlign textAlign; // New property for text alignment

  CustomText({
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.isUnderlined = false,
    this.textAlign = TextAlign.start, // Default alignment
  });

  double getResponsiveFontSize(BuildContext context, double size) {
    return size * MediaQuery.of(context).size.width / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize),
        color: color,
        decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign, // Apply alignment
    );
  }
}
