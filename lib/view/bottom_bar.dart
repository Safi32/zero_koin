import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zero_koin/view/calculator_screen.dart';
import 'package:zero_koin/view/home_screen.dart';

import 'package:zero_koin/view/two_person_screen.dart';
import 'package:zero_koin/view/user_profile_screen.dart';
import 'package:zero_koin/view/wallet_screen.dart';

class BottomBar extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    WalletScreen(),
    TwoPersonScreen(),
    UserProfileScreen(),
    CalculatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 29, 28, 28),
        buttonBackgroundColor: Colors.blue,
        color: Colors.black,
        height: 60,
        items: <Widget>[
          Image(image: AssetImage('assets/home_screen.png')),
          Image(image: AssetImage('assets/wallet.png')),
          Image(image: AssetImage('assets/two_person.png')),
          Image(image: AssetImage('assets/user_profile.png')),
          Image(image: AssetImage('assets/calculator.png')),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
