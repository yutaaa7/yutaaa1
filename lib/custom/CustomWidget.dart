import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final String? fontFamily;

  const CustomTextWidget({Key? key,  required this.title,
    this.icon,
    this.imageAsset,
  required this.fontFamily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
      children: [
        // Icon or image on the left
        icon != null
            ? Icon(icon, color: MyColorName.colorTextThird,)
            : imageAsset != null
            ? Image.asset(
          imageAsset!,
          width: 9,
          height: 13,
          color: Colors.white,
        )
            : SizedBox(width: 24), // Empty space if no icon/image provided

        // Title on the right
        Text(
          title,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MyColorName.colorTextThird,

          ),
        ),
      ],
    );
  }
}