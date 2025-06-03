import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocailMediaWidgets extends StatelessWidget {
  const SocailMediaWidgets({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/blur_background.png", height: 100, width: 100),
            SvgPicture.asset(imageUrl, height: 40, width: 40),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.white),
            backgroundColor: Color(0xFF0682A2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Follow", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
