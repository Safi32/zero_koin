import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zero_koin/widgets/home_page_widgets.dart';
import 'package:zero_koin/widgets/home_screen_widget.dart';
import 'package:dotted_border/dotted_border.dart';

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
                Container(
                  height: screenHeight * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/menu.png"),
                            Image.asset(
                              "assets/zero_koin_logo.png",
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.2,
                            ),
                            Image.asset("assets/notifcation.png"),
                          ],
                        ),
                        Text(
                          "Total Positions 77852",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            HomeScreenWidget(
                              title: "Mining",
                              subTitle: "500",
                              imageURl: "assets/mining.png",
                            ),
                            HomeScreenWidget(
                              title: "References",
                              subTitle: "100",
                              imageURl: "assets/references.png",
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
                            HomeScreenWidget(
                              title: "Referrals",
                              subTitle: "10",
                              imageURl: "assets/referrals.png",
                            ),
                            HomeScreenWidget(
                              title: "Mining",
                              subTitle: "1/4",
                              imageURl: "assets/power.png",
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
                                    child: Container(
                                      width: double.infinity,
                                      height: screenHeight * 0.1,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
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
                                        "Completetly Free - No KYC Required. \n Invite more friends and support the \n growth of the ecosystem",
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
