import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:zero_koin/view/bottom_bar.dart';

class SignInSuccessful extends StatelessWidget {
  const SignInSuccessful({super.key});

  void _goToHomeScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => BottomBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _goToHomeScreen(context),
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Background.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                Image.asset(
                  'assets/zero_koin_logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 30),
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.5,
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/success_icon.png'),
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Sign In \n Successful',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Please wait... \n You will be directed to the homepage soon',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
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
