import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';
import 'package:zero_koin/widgets/pop_up_button.dart';

class TimerPopup extends StatelessWidget {
  const TimerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final containerWidth = screenWidth * 0.8;
    final containerPadding = screenWidth * 0.05; // Responsive padding
    final titleFontSize = screenWidth * 0.055; // Responsive title font size
    final imageHeight = screenHeight * 0.25; // Responsive image height
    final verticalSpacing1 = screenHeight * 0.015; // Responsive spacing
    final verticalSpacing2 = screenHeight * 0.02; // Responsive spacing
    final buttonHeight = screenHeight * 0.06; // Responsive button height
    final buttonTextFontSize = screenWidth * 0.04; // Responsive button text font size

    // Calculate minimum required height (simplified)
    final titleHeight = titleFontSize * 1.2; // Approximate height for title
    final totalSpacing = verticalSpacing1 + verticalSpacing2; // 2 spacing elements
    final totalPadding = containerPadding * 2; // Top and bottom padding
    final minRequiredHeight = titleHeight + imageHeight + buttonHeight + totalSpacing + totalPadding;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
    final containerHeight =
        (minRequiredHeight > screenHeight * 0.8)
            ? screenHeight * 0.8
            : (minRequiredHeight < screenHeight * 0.3 ? screenHeight * 0.3 : minRequiredHeight);

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Timer Start",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: verticalSpacing1),
          Flexible(
            child: Image(
              image: AssetImage("assets/Timer.png"),
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: verticalSpacing2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PopUpButton(
                  buttonText: "Claim",
                  buttonColor: AppColors.lightBlue,
                  onPressed: () {},
                  textColor: Colors.white,
                  borderColor: Colors.blue,
                  fontSize: buttonTextFontSize, // Use responsive font size
                ),
              ),
              SizedBox(width: screenWidth * 0.03), // Responsive spacing between buttons
              Expanded(
                child: PopUpButton(
                  buttonText: "Boost",
                  buttonColor: Colors.white,
                  onPressed: () {},
                  textColor: Colors.black,
                  borderColor: Colors.blue,
                  fontSize: buttonTextFontSize, // Use responsive font size
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
