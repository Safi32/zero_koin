import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';
import 'package:zero_koin/widgets/pop_up_button.dart';

class TimerPopup extends StatelessWidget {
  const TimerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.55,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Timer Start",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Image(image: AssetImage("assets/Timer.png")),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopUpButton(
                buttonText: "Claim",
                buttonColor: AppColors.lightBlue,
                onPressed: () {},
                textColor: Colors.white,
                borderColor: Colors.blue,
              ),
              PopUpButton(
                buttonText: "Boost",
                buttonColor: Colors.white,
                onPressed: () {},
                textColor: Colors.black,
                borderColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
