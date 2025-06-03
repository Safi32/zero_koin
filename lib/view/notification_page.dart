import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controllers/theme_controller.dart';
import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/my_drawer.dart';
import 'package:zero_koin/widgets/notifcation_popup.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ThemeController themeController = Get.find<ThemeController>();
    
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Image.asset(
            "assets/Background.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBarContainer(color: Colors.black.withOpacity(0.6), showTotalPosition: false),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Image(
                              image: AssetImage("assets/arrow_back.png"),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Upcoming Notifications",
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color: themeController.isDarkMode ? Colors.grey[900] : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/zerokoingold.png",
                              width: screenHeight * 0.06,
                              height: screenHeight * 0.06,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Share the Journey",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.018,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "For every friend you bring you share",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.016,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Share the Journey",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.018,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    color: themeController.contentBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Recent Notifications",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    fontWeight: FontWeight.bold,
                                    color: themeController.textColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5.0,
                                        sigmaY: 5.0,
                                      ),
                                      child: Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: NotifcationPopup(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: themeController.borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/zerokoingold.png",
                                      width: screenHeight * 0.06,
                                      height: screenHeight * 0.06,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: screenWidth * 0.05),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Share the Journey",
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.018,
                                            fontWeight: FontWeight.bold,
                                            color: themeController.textColor,
                                          ),
                                        ),
                                        Text(
                                          "For every friend you bring you share",
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.016,
                                            color: themeController.textColor,
                                          ),
                                        ),
                                        Text(
                                          "5 min ago",
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.016,
                                            fontWeight: FontWeight.bold,
                                            color: themeController.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Container(
                              width: double.infinity,
                              height: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: themeController.borderColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/zerokoingold.png",
                                    width: screenHeight * 0.06,
                                    height: screenHeight * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Share the Journey",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          fontWeight: FontWeight.bold,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                      Text(
                                        "For every friend you bring you share",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.016,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                      Text(
                                        "5 min ago",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.016,
                                          fontWeight: FontWeight.bold,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Container(
                              width: double.infinity,
                              height: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: themeController.borderColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/zerokoingold.png",
                                    width: screenHeight * 0.06,
                                    height: screenHeight * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Share the Journey",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          fontWeight: FontWeight.bold,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                      Text(
                                        "For every friend you bring you share",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.016,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                      Text(
                                        "5 min ago",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.016,
                                          fontWeight: FontWeight.bold,
                                          color: themeController.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  color: themeController.isDarkMode ? themeController.contentBackgroundColor : Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
