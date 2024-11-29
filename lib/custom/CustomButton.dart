import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double? height;
  final double? width;
  final double borderRadius;
  final String? fontFamily;
  final double? fontSize;
  final double? letterSpacing;


  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    required this.fontFamily,
     this.fontSize,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = height ?? screenSize.height * 0.07;
    final buttonWidth = width ?? MediaQuery.of(context).size.width / 1.1;//screenSize.width * 0.9;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // padding:EdgeInsets.symmetric(vertical: 15,horizontal: 15),
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,

            style: TextStyle(
              color: MyColorName.colorBg1,
              // fontSize: 22.0,
              letterSpacing: letterSpacing,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
                fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
