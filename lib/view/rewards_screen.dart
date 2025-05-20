import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zero_koin/view/learn_and_earn.dart';
import 'package:zero_koin/view/socail_media_pages.dart';
import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/rewards_widget.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                AppBarContainer(showTotalPosition: false, color: Colors.black),
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
                            "Earn Rewards",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/stroke.png',
                                width: screenWidth * 0.3,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your Total ZeroKoins",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.06,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage("assets/trophy.png"),
                                      ),

                                      const SizedBox(height: 8, width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "1200 Coins",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.06,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Once you reach 6000 ZeroKoins, you’ll \n be eligible to make a withdrawal.",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: screenWidth * 0.03,
                                            ),
                                          ),
                                        ],
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
                SizedBox(height: 20),
                Container(
                  height: screenHeight * 0.55,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "More Reward",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            RewardsWidget(
                              onPressed: () {
                                Get.to(() => const SocailMediaPages());
                              },
                              imageUrl: "assets/social.png",
                              title: "Follow Socail Media Earn",
                            ),
                            SizedBox(height: 20),
                            RewardsWidget(
                              onPressed: () {
                                Get.to(() => LearnAndEarn());
                              },
                              imageUrl: "assets/learn.png",
                              title: "Learn and Earn Daily",
                            ),
                            SizedBox(height: 20),
                            RewardsWidget(
                              onPressed: () {},
                              imageUrl: "assets/invite_friend.png",
                              title: "Invite Friends",
                            ),
                            SizedBox(height: 30),
                            SizedBox(
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
                                child: Text("Withdraw"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
