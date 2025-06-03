import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';

class SessionPopup extends StatelessWidget {
  const SessionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final containerWidth = screenWidth * 0.8;
    final containerPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.04;
    final sessionButtonHeight = screenHeight * 0.07;
    final sessionFontSize = screenWidth * 0.045;
    final verticalSpacing = screenHeight * 0.015;
    final closeIconSize = screenWidth * 0.06;

    // Calculate minimum required height (simplified)
    final headerHeight = screenHeight * 0.05; // Estimate header height
    final totalSessionsHeight = sessionButtonHeight * 4; // 4 session buttons
    final totalSpacing = verticalSpacing * 5; // 5 spacing elements
    final totalPadding = containerPadding * 2; // Top and bottom padding
    final minRequiredHeight = headerHeight + totalSessionsHeight + totalSpacing + totalPadding;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
     final containerHeight =
        (minRequiredHeight > screenHeight * 0.8)
            ? screenHeight * 0.8
            : (minRequiredHeight < screenHeight * 0.4 ? screenHeight * 0.4 : minRequiredHeight);

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 5, 14, 22),
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01), // Adjust padding
                  child: Center(
                    child: Text(
                      "Complete your session \n every 6 hours",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                iconSize: closeIconSize, // Responsive icon size
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: verticalSpacing),
          Container(
            width: double.infinity, // Use double.infinity for full width
            height: sessionButtonHeight,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 1",
                    style: TextStyle(
                      fontSize: sessionFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset(
                    "assets/session_clock.png",
                    height: sessionFontSize, // Responsive image size based on text
                    width: sessionFontSize, // Responsive image size based on text
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          Container(
            width: double.infinity, // Use double.infinity for full width
            height: sessionButtonHeight,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 2",
                    style: TextStyle(
                      fontSize: sessionFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset(
                    "assets/session_clock.png",
                     height: sessionFontSize, // Responsive image size based on text
                    width: sessionFontSize, // Responsive image size based on text
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          Container(
            width: double.infinity, // Use double.infinity for full width
            height: sessionButtonHeight,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 3",
                    style: TextStyle(
                      fontSize: sessionFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset(
                    "assets/session_clock.png",
                     height: sessionFontSize, // Responsive image size based on text
                    width: sessionFontSize, // Responsive image size based on text
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          Container(
            width: double.infinity, // Use double.infinity for full width
            height: sessionButtonHeight,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 4",
                    style: TextStyle(
                      fontSize: sessionFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset(
                    "assets/session_clock.png",
                    height: sessionFontSize, // Responsive image size based on text
                    width: sessionFontSize, // Responsive image size based on text
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
