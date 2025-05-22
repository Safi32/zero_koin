import 'package:flutter/material.dart';

class GuideText extends StatelessWidget {
  const GuideText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: Color(0xFF948282), radius: 3),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Color(0xFF948282), fontSize: 15)),
        ],
      ),
    );
  }
}
