import 'package:flutter/material.dart';
import '../colors.dart';

class CstAppbarWithtextimage extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final String? fontFamily;
  final VoidCallback? onImageTap; // Callback for image tap

  const CstAppbarWithtextimage({
    Key? key,
    required this.title,
    this.icon,
    this.imageAsset,
    required this.fontFamily,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
      children: [
        icon != null
            ? Icon(icon, color: MyColorName.colorTextThird)
            : SizedBox(width: 24), // Empty space if no icon/image provided
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize:20,

              fontWeight: FontWeight.bold,
              color: MyColorName.colorTextThird,
            ),
          ),
        ),
    GestureDetector(
    onTap: onImageTap,
    child: imageAsset != null
            ? Container(
          width: 24,
          height: 24,
          child: Image.asset(
            imageAsset!,
            width: 24,
            height: 24,
            // color: Colors.blueGrey,
          ),
        )
            : SizedBox(width: 24),
    )// Empty space if no image provided
      ],
    );
  }
}
