import 'package:flutter/material.dart';

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
    required this.textColor,
    required this.borderColor,
  });

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final void Function() onPressed;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        side: BorderSide(color: borderColor, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.015,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
