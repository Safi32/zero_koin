import 'package:flutter/material.dart';

class WalletWeb3Widget extends StatelessWidget {
  const WalletWeb3Widget({
    super.key,
    required this.containerColor,
    required this.imageUrl,
    required this.text,
    this.fontSize = 15,
  });

  final Color containerColor;
  final String imageUrl;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 320.46,
      height: 56.18,
      padding: const EdgeInsets.all(12.77),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: containerColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: imageUrl.contains('zero_koin_logo') ? 15 : 30,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 12.77),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
