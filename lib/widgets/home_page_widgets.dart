import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controllers/theme_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(
      () => Container(
        width: double.infinity,
        height: screenHeight * 0.09, // Adjusted height for responsiveness
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: themeController.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8, // Further reduced padding
            vertical: 6, // Further reduced padding
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.13, // Further reduced width
                height: screenHeight * 0.06, // Further reduced height
                child: imageURL.toLowerCase().endsWith('.svg')
                    ? SvgPicture.asset(
                        imageURL,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(imageURL),
              ),
              SizedBox(width: screenWidth * 0.03), // Further reduced gap
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.018,
                          color: themeController.textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1), // Further reduced gap
                    Text(
                      subtitle,
                      style: TextStyle(
                        color:
                            subtitle == '600'
                                ? themeController.textColor
                                : themeController.subtitleColor,
                        fontSize: subtitle == '600' ? screenHeight * 0.017 : screenHeight * 0.012,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.03), // Further reduced gap
              SizedBox(
                width: screenWidth * 0.28, // Further reduced width
                height: screenHeight * 0.05, // Further reduced height
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjusted border radius
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.012), // Further reduced padding
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonImage.contains('solar_play')
                            ? screenWidth * 0.03  // Smaller size for play button
                            : screenWidth * 0.05, // Larger size for invite button
                        height: buttonImage.contains('solar_play')
                            ? screenHeight * 0.018  // Smaller size for play button
                            : screenHeight * 0.025, // Larger size for invite button
                        child: buttonImage.toLowerCase().endsWith('.svg')
                            ? SvgPicture.asset(
                                buttonImage,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(buttonImage),
                      ),
                      SizedBox(width: screenWidth * 0.01), // Further reduced gap
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
