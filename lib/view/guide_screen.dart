import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/guide_text.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AppBarContainer(color: Colors.black, showTotalPosition: false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image(image: AssetImage("assets/arrow_back.png")),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Guide",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/missing_information.png"),
                          SizedBox(width: 10),
                          Text(
                            "ZeroKoin Guide",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "What is ZeroKoin?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Redefining crypto with tokenized learning, \n smart tools & real-world rewards. Built for \n scale. Every revolution begins from Zero.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF948282),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Start Mining - Earn 30 \n ZeroKoins Every 6 Hours",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          GuideText(title: "Sign in with your Google account."),
                          GuideText(title: "New users get 1 free Energy."),
                          GuideText(
                            title:
                                "You can mine up to 4 times a day, with 1 \n session every 6 hours",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xFF948282),
                                  radius: 3,
                                ),
                                SizedBox(width: 10),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF948282),
                                      fontSize: 15,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: "Tap the "),
                                      TextSpan(
                                        text: "\"GET KOIN\"",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            " button to earn 30 \nZeroKoins per session",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/guide_screen_01.png"),
                      SizedBox(height: 20),
                      Text(
                        "More Rewards (Bonus)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "After GET ZEROKOIN, tap "),
                                  TextSpan(
                                    text: "\"More Rewards\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GuideText(
                        title:
                            "Follow our social media pages to receive \n extra ZeroKoins as a bonus",
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/guide_screen_02.png"),
                      SizedBox(height: 20),
                      Text(
                        "Learn And Earn Daily Rewards:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30),
                      GuideText(title: "Learn & Earn - Daily Learning Rewards"),
                      GuideText(title: "Go to the learning sections."),
                      GuideText(
                        title: "Every day, you'll get 5 pages to read.",
                      ),
                      GuideText(
                        title:
                            "Each page requires you to read and \n understand for 2 minutes.",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "After 2 minutes, the "),
                                  TextSpan(
                                    text: "\"Next\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " button will \n appear to go to next page.",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GuideText(
                        title:
                            "When you complete all 5 pages in a day, \n you'll earn 10 ZeroKoins as a reward",
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/guide_screen_03.png"),
                      SizedBox(height: 20),
                      Text(
                        "How to Add ZeroKoin to \n MetaMask & Get Your \n Address:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30),
                      GuideText(
                        title:
                            "Go to the Play Store and search for \n MetaMask.",
                      ),
                      GuideText(
                        title: "Download and install the MetaMask app.",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Open the app and tap "),
                                  TextSpan(
                                    text: "\"Add\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Select "),
                                  TextSpan(
                                    text: "\"Custom Token\"",
                                    style: TextStyle(
                                      color: Color(0xFF948282),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GuideText(
                        title:
                            "Paste the following ZeroKoin contract \n address:",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "0x99349F73449b2BDFa63deFB05770df0\n4fD70E97",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Image.asset("assets/copy.png"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Tap the "),
                                  TextSpan(
                                    text: "\"Next\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " button."),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GuideText(title: "Confirm that the token shows 0 KOIN."),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Tap "),
                                  TextSpan(
                                    text: "\"Next\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " again."),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "You will see a message: "),
                                  TextSpan(
                                    text: "\"Import Successful\"",
                                    style: TextStyle(
                                      color: Color(0xFF948282),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Tap the "),
                                  TextSpan(
                                    text: "\"Import\"",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " button to finish."),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Tap ZeroKoin, then tap "),
                                  TextSpan(
                                    text: "\"Receive\"",
                                    style: TextStyle(
                                      color: Color(0xFF948282),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " to view\n your ZeroKoin wallet address.",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/guide_screen_04.png"),
                      SizedBox(height: 20),
                      Text(
                        "Invite & Earn:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF948282),
                              radius: 3,
                            ),
                            SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF948282),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: "Step 1: "),
                                  TextSpan(
                                    text: "\"Invite & Earn\"",
                                    style: TextStyle(
                                      color: Color(0xFF948282),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " Enter this section."),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GuideText(
                        title:
                            "Step 2: Here you can copy or share your\n reference number",
                      ),
                      GuideText(
                        title:
                            "After your friend clicks on the link and\n installs the application and registers, you\n will be rewarded.",
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/guide_screen_05.png"),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
