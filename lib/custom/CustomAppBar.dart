import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;

  CustomAppBar({
    required this.title,
    this.icon,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Prevent default back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
        children: [
          icon != null
              ? Icon(icon, color: MyColorName.colorfillBOx)
              : imageAsset != null
              ? Image.asset(
            imageAsset!,
            width: 24,
            height: 24,
            color:  MyColorName.colorfillBOx,
          )
              : SizedBox(width: 24), // Empty space if no icon/image provided
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColorName.colorfillBOx,
            ),
          ),
        ],
      ),
      backgroundColor:MyColorName.colorButton,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
