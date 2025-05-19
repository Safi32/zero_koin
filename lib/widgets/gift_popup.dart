import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';

class GiftPopup extends StatelessWidget {
  const GiftPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.45,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/gift_background.png'),
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'TO Watch an Add \n You win a gift',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Please wait... \n You will be directed to the homepage soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
