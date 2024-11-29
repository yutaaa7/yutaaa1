import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
//  final IconData icon;
  final IconData? secondaryIcon;
  final bool obscureText;

  final bool readOnly;
  final int? maxLength;
  final TextInputType keyboardType; // Add this for keyboard type
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
  //  required this.labelText,
    required this.hintText,
    required this.controller,
 //   required this.icon,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType = TextInputType.text, // Default to text if not provided
    this.secondaryIcon,
    this.obscureText = false,



    required this.onChanged,
    this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height* 0.07,
      // width: MediaQuery.of(context).size.width / 1.1,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: Colors.grey,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,// Use the readOnly property from widget
        keyboardType: widget.keyboardType, // Set keyboard type

        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          counterText: "",
          //labelText: widget.labelText,
          hintText: widget.hintText,
          filled: true,

          fillColor: MyColorName.primaryLite.withOpacity(0.15),//Colors.grey[200],
          // fillColor: MyColorName.colorgray.withOpacity(0.05),//Colors.grey[200],
          //prefixIcon: Icon(widget.icon),
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          )
              : (widget.secondaryIcon != null
              ? Icon(widget.secondaryIcon)
              : null),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey, // Set the color when the field is selected
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey[400]!, // Set the default border color
            ),
          ),
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
