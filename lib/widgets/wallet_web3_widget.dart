import 'package:flutter/material.dart';

class WalletWeb3Widget extends StatelessWidget {
  const WalletWeb3Widget({
    super.key,
    required this.containerColor,
    required this.imageUrl,
    required this.text,
  });

  final Color containerColor;
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.08,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imageUrl),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
