import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controller/language_controller.dart';

import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/learn_and_earn_widget.dart';
import 'package:zero_koin/widgets/progress_popup.dart';

class LearnAndEarn extends StatelessWidget {
  const LearnAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final LanguageController controller = Get.put(LanguageController());

    Widget buildLanguageOption(String language) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF0682A2), width: 2),
        ),
        child: TextButton(
          onPressed: () => controller.selectLanguage(language),
          child: Text(
            language,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
            height: screenHeight,
            width: screenWidth,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBarContainer(color: Colors.black, showTotalPosition: false),
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
                            onTap: () => Navigator.pop(context),
                            child: const Image(
                              image: AssetImage("assets/arrow_back.png"),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      DottedBorder(
                        options: const RectDottedBorderOptions(
                          color: Colors.grey,
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
                                  child: const Dialog(
                                    backgroundColor: Colors.transparent,
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
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Upload An Add",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: screenHeight * 0.7,
                  width: screenWidth,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: controller.toggleDropdown,
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF0682A2),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "assets/language.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.selectedLanguage.value,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Icon(
                                            controller.isDropdownOpen.value
                                                ? Icons.arrow_drop_up_sharp
                                                : Icons.arrow_drop_down_sharp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  if (controller.isDropdownOpen.value) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: Column(
                                          children:
                                              controller.languages
                                                  .map(
                                                    (language) =>
                                                        buildLanguageOption(
                                                          language,
                                                        ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              ],
                            ),
                            LearnAndEarnWidget(
                              title: "Learn NFT's",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LearnAndEarnWidget(
                              title: "Learn Crypto",
                              onPressed: () {},
                            ),
                            LearnAndEarnWidget(
                              title: "Learn Blockchain",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LearnAndEarnWidget(
                              title: "Learn Mining",
                              onPressed: () {},
                            ),
                            LearnAndEarnWidget(
                              title: "Learn Stock Market",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Earn 10 Koins Daily By Learning!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
