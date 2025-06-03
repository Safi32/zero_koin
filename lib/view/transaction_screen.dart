import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controllers/theme_controller.dart';
import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/my_drawer.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: themeController.backgroundColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.35),
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              AppBarContainer(color: Colors.black.withOpacity(0.6), showTotalPosition: false),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: themeController.contentBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: screenHeight * 0.225,
                          width: screenHeight * 0.25,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: themeController.cardColor,
                              border: Border.all(
                                color: themeController.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "Ad",
                              style: TextStyle(color: themeController.textColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        height: 120,
                        child: Image.asset(
                          "assets/oops.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Oops!",
                        style: TextStyle(
                          fontSize: 38,
                          color: themeController.subtitleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Nothing great ever come that easy.",
                        style: TextStyle(
                          fontSize: 18,
                          color: themeController.subtitleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

