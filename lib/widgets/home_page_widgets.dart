import 'package:flutter/material.dart';

class HomePageWidgets extends StatelessWidget {
  const HomePageWidgets({
    super.key,
    required this.title,

    required this.subtitle,
    required this.imageURL,

    required this.buttonText,
    required this.color,
    required this.buttonImage,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final String imageURL;
  final String buttonImage;
  final String buttonText;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imageURL),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.02,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenHeight * 0.012,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(buttonImage),
                  SizedBox(width: 8),
                  Text(buttonText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
