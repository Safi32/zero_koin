import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/controllers/theme_controller.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});
  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      backgroundColor: themeController.backgroundColor,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: screenHeight * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: themeController.gradientColors,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
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
                          "Help and Support",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: themeController.contentBackgroundColor,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top-right action icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  // Handle attach file
                                },
                                icon: Icon(
                                  Icons.attach_file,
                                  color: themeController.subtitleColor,
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  // Handle send
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: themeController.subtitleColor,
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  // Handle more options
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: themeController.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Email Form Container
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: themeController.cardColor,
                              border: Border.all(
                                color: themeController.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "From  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: themeController.subtitleColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _fromController,
                                          style: TextStyle(
                                            color: themeController.textColor,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                            hintText: "anasqueshipak@gmail.com",
                                            hintStyle: TextStyle(
                                              color:
                                                  themeController.subtitleColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "To  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: themeController.subtitleColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _toController,
                                          readOnly: true,
                                          style: TextStyle(
                                            color: themeController.textColor,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                            hintText: "info@zerokoin.com",
                                            hintStyle: TextStyle(
                                              color:
                                                  themeController.subtitleColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Text(
                                    "Zerokoin Network Support : Anas queshi",
                                    style: TextStyle(
                                      color: themeController.subtitleColor,
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "User  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: themeController.subtitleColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _userController,
                                          style: TextStyle(
                                            color: themeController.textColor,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
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
