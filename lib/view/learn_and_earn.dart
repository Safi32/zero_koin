import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controller/language_controller.dart';
import 'package:zero_koin/controllers/theme_controller.dart';
import 'package:zero_koin/view/bottom_bar.dart';

import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/learn_and_earn_widget.dart';
import 'package:zero_koin/widgets/my_drawer.dart';

import 'package:zero_koin/widgets/earn_rewards.dart';

class LearnAndEarn extends StatefulWidget {
  const LearnAndEarn({super.key});

  @override
  State<LearnAndEarn> createState() => _LearnAndEarnState();
}

class _LearnAndEarnState extends State<LearnAndEarn> {
  late ScrollController _scrollController;
  double _scrollPosition = 0.0;

  // Timer variables
  Timer? _timer;
  int _remainingSeconds = 120; // 2 minutes = 120 seconds
  bool _isTimerRunning = false;
  bool _isTimerPaused = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _updateScrollPosition() {
    setState(() {
      _scrollPosition = _scrollController.offset;
    });
  }

  // Timer methods
  void _startTimer() {
    if (!_isTimerRunning && !_isTimerPaused) {
      setState(() {
        _isTimerRunning = true;
        _isTimerPaused = false;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _stopTimer();
          }
        });
      });
    }
  }

  void _pauseTimer() {
    if (_isTimerRunning) {
      setState(() {
        _isTimerRunning = false;
        _isTimerPaused = true;
      });
      _timer?.cancel();
    }
  }

  void _resumeTimer() {
    if (_isTimerPaused) {
      setState(() {
        _isTimerRunning = true;
        _isTimerPaused = false;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _stopTimer();
          }
        });
      });
    }
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
      _isTimerPaused = false;
      // Don't reset timer - keep it at 0 when countdown completes
    });
    _timer?.cancel();

    // Show EarnRewards popup when timer ends
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: EarnRewards(zerokoins: 2),
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ThemeController themeController = Get.find<ThemeController>();

    final LanguageController controller = Get.put(LanguageController());

    return Scaffold(
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
            height: screenHeight,
            width: screenWidth,
          ),
          Column(
            children: [
              AppBarContainer(color: Colors.black.withValues(alpha: 0.6), showTotalPosition: false),
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
                            if (Navigator.canPop(context)) {
                              Get.back();
                            } else {
                              Get.offAll(() => const BottomBar());
                            }
                          },
                          child: const Image(
                            image: AssetImage("assets/arrow_back.png"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Text(
                            controller.getTranslation("back"),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Simple Ad Placeholder
                    Container(
                      width: 320,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Ad",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.02,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: themeController.contentBackgroundColor,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFF0682A2),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/language.png",
                                          width: 18,
                                          height: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Obx(
                                            () => DropdownButton<String>(
                                              value:
                                                  controller
                                                              .selectedLanguage
                                                              .value ==
                                                          "Language"
                                                      ? null
                                                      : controller
                                                          .selectedLanguage
                                                          .value,
                                              hint: Obx(
                                                () => Text(
                                                  controller.getTranslation(
                                                    "language",
                                                  ),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth < 360
                                                            ? 11
                                                            : 13,
                                                    color:
                                                        themeController
                                                            .textColor,
                                                  ),
                                                  textDirection:
                                                      controller
                                                                      .selectedLanguage
                                                                      .value ==
                                                                  "Urdu" ||
                                                              controller
                                                                      .selectedLanguage
                                                                      .value ==
                                                                  "Arabic"
                                                          ? TextDirection.rtl
                                                          : TextDirection.ltr,
                                                ),
                                              ),
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color:
                                                    themeController.textColor,
                                                size: 20,
                                              ),
                                              selectedItemBuilder: (
                                                BuildContext context,
                                              ) {
                                                return controller.languages.map<
                                                  Widget
                                                >((String language) {
                                                  bool isRTL =
                                                      language == "Urdu" ||
                                                      language == "Arabic";
                                                  return Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      language,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenWidth < 360
                                                                ? 11
                                                                : 13,
                                                        color:
                                                            themeController
                                                                .textColor,
                                                      ),
                                                      textDirection:
                                                          isRTL
                                                              ? TextDirection
                                                                  .rtl
                                                              : TextDirection
                                                                  .ltr,
                                                    ),
                                                  );
                                                }).toList();
                                              },
                                              dropdownColor:
                                                  themeController
                                                      .contentBackgroundColor,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    screenWidth < 360 ? 11 : 13,
                                                color:
                                                    themeController.textColor,
                                              ),
                                              items:
                                                  controller.languages.asMap().entries.map((
                                                    entry,
                                                  ) {
                                                    int index = entry.key;
                                                    String language =
                                                        entry.value;
                                                    bool isLastItem =
                                                        index ==
                                                        controller
                                                                .languages
                                                                .length -
                                                            1;

                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: language,
                                                      child: Container(
                                                        width: double.infinity,
                                                        margin:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 8.0,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 12.0,
                                                              horizontal: 16.0,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color(
                                                              0xFFC4B0B0,
                                                            ),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8.0,
                                                              ),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment
                                                                  .centerLeft,
                                                          child: Text(
                                                            language,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  screenWidth <
                                                                          360
                                                                      ? 11
                                                                      : 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  themeController
                                                                      .textColor,
                                                            ),
                                                            textDirection:
                                                                language ==
                                                                            "Urdu" ||
                                                                        language ==
                                                                            "Arabic"
                                                                    ? TextDirection
                                                                        .rtl
                                                                    : TextDirection
                                                                        .ltr,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                              onChanged: (String? newValue) {
                                                if (newValue != null) {
                                                  controller.selectLanguage(
                                                    newValue,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(
                                  () => LearnAndEarnWidget(
                                    title: controller.getTranslation(
                                      "learn_nfts",
                                    ),
                                    isSelected: controller.isCategorySelected(
                                      "Learn NFT's",
                                    ),
                                    onPressed: () {
                                      controller.selectCategory("Learn NFT's");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => LearnAndEarnWidget(
                                    title: controller.getTranslation(
                                      "learn_crypto",
                                    ),
                                    isSelected: controller.isCategorySelected(
                                      "Learn Crypto",
                                    ),
                                    onPressed: () {
                                      controller.selectCategory("Learn Crypto");
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(
                                  () => LearnAndEarnWidget(
                                    title: controller.getTranslation(
                                      "learn_blockchain",
                                    ),
                                    isSelected: controller.isCategorySelected(
                                      "Learn Blockchain",
                                    ),
                                    onPressed: () {
                                      controller.selectCategory(
                                        "Learn Blockchain",
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => LearnAndEarnWidget(
                                    title: controller.getTranslation(
                                      "learn_mining",
                                    ),
                                    isSelected: controller.isCategorySelected(
                                      "Learn Mining",
                                    ),
                                    onPressed: () {
                                      controller.selectCategory("Learn Mining");
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(
                                  () => LearnAndEarnWidget(
                                    title: controller.getTranslation(
                                      "learn_stock_market",
                                    ),
                                    isSelected: controller.isCategorySelected(
                                      "Learn Stock Market",
                                    ),
                                    onPressed: () {
                                      controller.selectCategory(
                                        "Learn Stock Market",
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    controller.getTranslation(
                                      "earn_koins_daily",
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth < 360 ? 16 : 18,
                                      color: themeController.textColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: screenHeight * 0.3,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.getTranslation(
                                            "page_number",
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          controller.getTranslation(
                                            "block_number",
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Expanded(
                                        child: Container(
                                          width: screenWidth * 0.8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: const Color.fromARGB(
                                              255,
                                              48,
                                              48,
                                              48,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            padding: const EdgeInsets.all(15),
                                            child: Obx(
                                              () => Text(
                                                controller.getTranslation(
                                                  "zerokoin_content",
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Custom Functional Scrollbar
                                Positioned(
                                  right: 10,
                                  top: 80,
                                  bottom: 20,
                                  child: _buildCustomScrollbar(screenHeight),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF0C091E),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.getTranslation("timer"),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _formatTime(_remainingSeconds),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      if (!_isTimerRunning && !_isTimerPaused) {
                                        _startTimer();
                                      } else if (_isTimerRunning) {
                                        _pauseTimer();
                                      } else if (_isTimerPaused) {
                                        _resumeTimer();
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF393746),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          _isTimerRunning
                                              ? Icons.pause_circle_outline
                                              : Icons.play_circle_outline,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(color: Color(0xFF0682A2)),
                                    backgroundColor:
                                        themeController.contentBackgroundColor,
                                    foregroundColor: Color(0xFF0682A2),
                                  ),
                                  onPressed: () {},
                                  child: Obx(
                                    () => Text(
                                      controller.getTranslation("previous"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color:
                                          themeController
                                              .contentBackgroundColor,
                                    ),
                                    backgroundColor:
                                        _remainingSeconds == 0
                                            ? Color(0xFF0682A2)
                                            : Colors.grey,
                                    foregroundColor:
                                        _remainingSeconds == 0
                                            ? Colors.white
                                            : Colors.white70,
                                  ),
                                  onPressed:
                                      _remainingSeconds == 0
                                          ? () {
                                            // Add your next button functionality here
                                            print(
                                              "Next button pressed - Timer completed!",
                                            );
                                          }
                                          : null,
                                  child: Obx(
                                    () =>
                                        Text(controller.getTranslation("next")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomScrollbar(double screenHeight) {
    // Calculate available height for scrollbar (container height minus padding)
    double availableHeight = screenHeight * 0.3 - 100; // Updated container height minus top/bottom padding

    if (!_scrollController.hasClients) {
      return Container(
        width: 8,
        height: availableHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withValues(alpha: 0.3),
        ),
      );
    }

    // Get scroll metrics
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double viewportDimension = _scrollController.position.viewportDimension;
    double totalContentHeight = maxScrollExtent + viewportDimension;

    // Calculate scrollbar thumb height based on content ratio
    double thumbHeight =
        (viewportDimension / totalContentHeight) * availableHeight;
    thumbHeight = thumbHeight.clamp(
      20.0,
      availableHeight * 0.8,
    ); // Min 20px, max 80% of track

    // Calculate thumb position
    double thumbPosition = 0.0;
    if (maxScrollExtent > 0) {
      double scrollRatio = _scrollPosition / maxScrollExtent;
      thumbPosition = scrollRatio * (availableHeight - thumbHeight);
      thumbPosition = thumbPosition.clamp(0.0, availableHeight - thumbHeight);
    }

    return Container(
      width: 8,
      height: availableHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withValues(alpha: 0.3),
      ),
      child: Stack(
        children: [
          Positioned(
            top: thumbPosition,
            child: Container(
              width: 8,
              height: thumbHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF0682A2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
