import 'package:flutter/material.dart';

class RewardsWidget extends StatelessWidget {
  const RewardsWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPressed,
  });

  final String imageUrl;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: screenHeight * 0.08,
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image(image: AssetImage(imageUrl)),
              SizedBox(width: screenWidth * 0.05),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
