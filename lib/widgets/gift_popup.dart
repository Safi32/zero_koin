import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';

class GiftPopup extends StatelessWidget {
  const GiftPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final isSmallDeviceHeight = screenHeight < 650; // Adjusted threshold for small height
    final containerWidth = screenWidth * 0.85; 
    // Adjusted padding and inner padding to be more responsive to height on small devices
    final containerPadding = isSmallDeviceHeight ? screenWidth * 0.03 + screenHeight * 0.01 : screenWidth * 0.05;
    final innerPadding = isSmallDeviceHeight ? screenWidth * 0.03 + screenHeight * 0.005 : screenWidth * 0.04;
    // Adjusted image size to be more responsive to height on small devices
    final imageSize = isSmallDeviceHeight ? screenWidth * 0.20 + screenHeight * 0.02 : screenWidth * 0.25;
    // Adjusted font sizes to be more responsive to height on small devices
    final titleFontSize = isSmallDeviceHeight ? screenWidth * 0.04 + screenHeight * 0.005 : screenWidth * 0.045;
    final subtitleFontSize = isSmallDeviceHeight ? screenWidth * 0.025 + screenHeight * 0.003 : screenWidth * 0.03;
    // Adjusted vertical spacing to be more responsive to height on small devices
    final verticalSpacing = isSmallDeviceHeight ? screenHeight * 0.015 : screenHeight * 0.02; // Slightly increased spacing for better look
    final closeButtonSize = isSmallDeviceHeight ? screenWidth * 0.045 : screenWidth * 0.05; // Further reduced close button size

    // Calculate minimum required height (simplified)
    final estimatedTitleHeight = titleFontSize * 3; // Estimate for 2-3 lines
    final estimatedSubtitleHeight = subtitleFontSize * 4; // Estimate for 3-4 lines
    final totalSpacing = verticalSpacing * 2; // Spacing between elements
    final totalPadding = (containerPadding + innerPadding); // Sum of vertical padding
    final closeButtonSpace = closeButtonSize * 1.2; // Estimate space for close button
    final minRequiredHeight = imageSize + estimatedTitleHeight + estimatedSubtitleHeight + totalSpacing + totalPadding + closeButtonSpace/2;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
    final maxContainerHeight = isSmallDeviceHeight ? screenHeight * 0.95 : screenHeight * 0.8; // Allow even larger height on very small devices

    final containerHeight =
        (minRequiredHeight > maxContainerHeight)
            ? maxContainerHeight
            : (minRequiredHeight < screenHeight * 0.35 ? screenHeight * 0.35 : minRequiredHeight); // Increased minimum height slightly

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: innerPadding,
              vertical: verticalSpacing,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/gift_background.png'),
                  height: imageSize,
                  width: imageSize,
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  'TO Watch an Add \n You win a gift',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFontSize, // Responsive font size
                    fontWeight: FontWeight.w900,
                    color: AppColors.blue,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  'Please wait... \n You will be directed to the homepage soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subtitleFontSize, // Responsive font size
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: screenWidth * 0.02, // Responsive positioning
            top: screenHeight * 0.01, // Responsive positioning
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.grey,
                size: closeButtonSize, // Responsive close icon size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
