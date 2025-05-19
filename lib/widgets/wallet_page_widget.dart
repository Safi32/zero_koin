import 'package:flutter/material.dart';

class WalletPageWidget extends StatelessWidget {
  const WalletPageWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.1,
      width: screenWidth * 0.42,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image(image: AssetImage("assets/wallet_page.png")),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
