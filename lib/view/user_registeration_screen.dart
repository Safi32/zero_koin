import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:zero_koin/view/sign_in_successful.dart';

class UserRegisterationScreen extends StatelessWidget {
  const UserRegisterationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Background.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Image.asset(
                  'assets/bluelogo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Zero Koin',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Opacity(
                            opacity: 0.1,
                            child: Image.asset(
                              'assets/bluelogo.png',
                              height: 400,
                              width: 400,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'By signing in with Google, you agree to Zero Koin\'s Terms of Service and confirm that you have read and understood our ',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: Color(0xFF00FFFF),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFF00FFFF),
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () async {
                                            const String urlString =
                                                'https://google.com';
                                            try {
                                              if (await url_launcher.canLaunch(
                                                urlString,
                                              )) {
                                                await url_launcher.launch(
                                                  urlString,
                                                  forceSafariVC: false,
                                                  forceWebView: false,
                                                );
                                              }
                                            } catch (e) {
                                              // Handle error silently
                                            }
                                          },
                                  ),
                                  TextSpan(text: '.'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.to(() => const SignInSuccessful());
                              },
                              icon: Image.asset(
                                "assets/google_icon.png",
                                height: 24,
                                width: 24,
                              ),
                              label: const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              'v1.0.0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
