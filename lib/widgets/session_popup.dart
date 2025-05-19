import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';

class SessionPopup extends StatelessWidget {
  const SessionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.53,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 5, 14, 22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Complete your session \n every 6 hours",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 1",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset("assets/session_clock.png"),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 2",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset("assets/session_clock.png"),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 3",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset("assets/session_clock.png"),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session 4",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Image.asset("assets/session_clock.png"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
