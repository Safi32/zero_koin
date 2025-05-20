import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zero_koin/view/notification_page.dart';

// class AppBarContainer extends StatelessWidget {
//   const AppBarContainer({super.key, required this.color});

//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       height: screenHeight * 0.2,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: color,
//         border: Border.all(color: Colors.white),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset("assets/menu.png"),
//                 Image.asset(
//                   "assets/zero_koin_logo.png",
//                   height: screenHeight * 0.1,
//                   width: screenWidth * 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.to(() => NotificationPage());
//                   },
//                   child: Image.asset("assets/notifcation.png"),
//                 ),
//               ],
//             ),
//             Text(
//               "Total Positions 77852",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.02,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    required this.color,
    this.showTotalPosition = true, // Default true
  });

  final Color color;
  final bool showTotalPosition;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/menu.png"),
                Image.asset(
                  "assets/zero_koin_logo.png",
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => NotificationPage());
                  },
                  child: Image.asset("assets/notifcation.png"),
                ),
              ],
            ),
            if (showTotalPosition)
              Text(
                "Total Positions 77852",
                style: TextStyle(
                  fontSize: screenWidth * 0.02,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
