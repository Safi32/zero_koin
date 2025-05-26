import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zero_koin/constant/app_colors.dart';
import 'package:zero_koin/view/block_chain_screen.dart';
import 'package:zero_koin/view/guide_screen.dart';
import 'package:zero_koin/view/help_ai.dart';
import 'package:zero_koin/view/help_support_screen.dart';
import 'package:zero_koin/view/play_store_screen.dart';
import 'package:zero_koin/view/settings_screen.dart';
import 'package:zero_koin/view/socail_media_pages.dart';
import 'package:zero_koin/view/transaction_screen.dart';
import 'package:zero_koin/view/white_paper_screen.dart';
import 'package:zero_koin/view/zero_web_screen.dart';
import 'package:zero_koin/view/zerokoin_buy.dart';
import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/drawer_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Drawer(
        child: Stack(
          children: [
            Image.asset(
              'assets/Background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: [
                AppBarContainer(color: Colors.black, showTotalPosition: false),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.18,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "W",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "John",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "xyz@gmail.com",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Image(image: AssetImage("assets/logout.png")),
                                ],
                              ),
                              Spacer(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "ACTIVE",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DrawerWidget(
                            imageUrl: "assets/icon_01.png",
                            title: "Follow Zerokoin",
                            onPressed: () {
                              Get.to(() => SocailMediaPages());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_02.png",
                            title: "Guide",
                            onPressed: () {
                              Get.to(() => GuideScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_03.png",
                            title: "Zerokoin Buy",
                            onPressed: () {
                              Get.to(() => ZerokoinBuy());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_04.png",
                            title: "Transactions",
                            onPressed: () {
                              Get.to(() => TransactionsScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_05.png",
                            title: "ZeroKoin Website",
                            onPressed: () {
                              Get.to(() => ZeroWebScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_06.png",
                            title: "Play Store",
                            onPressed: () {
                              Get.to(() => PlayStoreScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_07.png",
                            title: "Blockchain",
                            onPressed: () {
                              Get.to(() => BlockchainScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_08.png",
                            title: "Whitepaper",
                            onPressed: () {
                              Get.to(() => WhitePaperScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_09.png",
                            title: "Help AI (Telegram)",
                            onPressed: () {
                              Get.to(() => HelpAiScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_10.png",
                            title: "Help & Support",
                            onPressed: () {
                              Get.to(() => HelpSupportScreen());
                            },
                          ),
                          DrawerWidget(
                            imageUrl: "assets/icon_11.png",
                            title: "Setting",
                            onPressed: () {
                              Get.to(() => SettingsScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
