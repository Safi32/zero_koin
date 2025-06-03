import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controllers/theme_controller.dart';
import 'package:zero_koin/view/block_chain_screen.dart';
import 'package:zero_koin/view/guide_screen.dart';
import 'package:zero_koin/view/help_ai.dart';
import 'package:zero_koin/view/help_support_screen.dart';
import 'package:zero_koin/view/notification_page.dart';
import 'package:zero_koin/view/play_store_screen.dart';
import 'package:zero_koin/view/settings_screen.dart';
import 'package:zero_koin/view/socail_media_pages.dart';
import 'package:zero_koin/view/transaction_screen.dart';
import 'package:zero_koin/view/white_paper_screen.dart';
import 'package:zero_koin/view/zero_web_screen.dart';
import 'package:zero_koin/view/zerokoin_buy.dart';
import 'package:zero_koin/widgets/drawer_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ThemeController themeController = Get.find<ThemeController>();

    return SizedBox(
      width: screenWidth * 0.65,
      child: Drawer(
        child: Stack(
          children: [
            Image.asset(
              'assets/homebackground.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Obx(
              () => Column(
                children: [
                  // Removed header section
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.07,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF086F8A),
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "W",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "John",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenHeight * 0.018,
                                        ),
                                      ),
                                      Text(
                                        "xyz@gmail.com",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenHeight * 0.016,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 36,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0882A2),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/logout.svg",
                                        width: 22,
                                        height: 20,
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
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeController.contentBackgroundColor,
                      ),
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
                            Divider(
                              thickness: 1,
                              color: themeController.textColor.withOpacity(0.2),
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
                              onPressed: () async {
                                const url = 'https://bscscan.com/address/0x99349F73449b2BDFa631deFB0570df04afD70E97';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  // Handle error, e.g., show a snackbar
                                  Get.snackbar(
                                    'Error',
                                    'Could not launch $url',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                            ),
                            DrawerWidget(
                              imageUrl: "assets/icon_08.png",
                              title: "Whitepaper",
                              onPressed: () {
                                Get.to(() => WhitePaperScreen());
                              },
                            ),
                            Divider(
                              thickness: 1,
                              color: themeController.textColor.withOpacity(0.2),
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
            ),
          ],
        ),
      ),
    );
  }
}
