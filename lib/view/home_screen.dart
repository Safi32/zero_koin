import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/earn_rewards.dart';
import 'package:zero_koin/widgets/gift_popup.dart';
import 'package:zero_koin/widgets/home_page_widgets.dart';
import 'package:zero_koin/widgets/home_screen_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:zero_koin/widgets/progress_popup.dart';
import 'package:zero_koin/widgets/session_popup.dart';
import 'package:zero_koin/widgets/timer_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBarContainer(
                  color: Colors.transparent,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                        child: SessionPopup(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: HomeScreenWidget(
                                title: "Mining",
                                subTitle: "500",
                                imageURl: "assets/mining.png",
                              ),
                            ),
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
                                        child: GiftPopup(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: HomeScreenWidget(
                                title: "References",
                                subTitle: "100",
                                imageURl: "assets/references.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                        child: TimerPopup(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: HomeScreenWidget(
                                title: "Referrals",
                                subTitle: "10",
                                imageURl: "assets/referrals.png",
                              ),
                            ),
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
                                        child: EarnRewards(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: HomeScreenWidget(
                                title: "Power",
                                subTitle: "1/4",
                                imageURl: "assets/power.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  DottedBorder(
                                    options: RectDottedBorderOptions(
                                      dashPattern: [10, 5],
                                      strokeWidth: 2,
                                    ),
                                    child: GestureDetector(
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
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ProgressPopup(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: screenHeight * 0.1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Upload An Add",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenHeight * 0.02,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.04),
                                  HomePageWidgets(
                                    title: "Total ZEROKOIN",
                                    subtitle: "600",
                                    imageURL: "assets/mining.png",
                                    buttonImage: "assets/play_button.png",
                                    buttonText: "Start",
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: screenHeight * 0.03),
                                  HomePageWidgets(
                                    title: "Invite to Friend",
                                    subtitle:
                                        "invite your friends & earn \n 50 for Zerokoin referrals",
                                    imageURL: "assets/invite_user.png",
                                    buttonImage: "assets/invite.png",
                                    buttonText: "Invite",
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: SizedBox(
                                width: Get.width,
                                height: screenHeight * 0.07,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text("Get More Rewards"),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/missing_information.png",
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        "Missing Information",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.03),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/gift.png"),
                                      SizedBox(width: screenWidth * 0.05),
                                      Text(
                                        "Invite Friends & Earn 50 Zerokoin! \n Earn 50 Zerokoin for every successful \n referral...",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/Vector (1).png"),
                                      SizedBox(width: screenWidth * 0.05),
                                      Text(
                                        "Earn 30 Zerokoin every 6 hours! \n Stay active and keep collecting rewards\nregularly",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/rocket.png"),
                                      SizedBox(width: screenWidth * 0.03),
                                      Text(
                                        "Follow us & get 30 Zerokoin!",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/Vector.png"),
                                      SizedBox(width: screenWidth * 0.05),
                                      Text(
                                        "Completely Free - No KYC Required. \n Invite more friends and support the \n growth of the ecosystem",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Image.asset("assets/launching_soon.png"),
                                  SizedBox(height: screenHeight * 0.02),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
