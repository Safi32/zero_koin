import 'package:flutter/material.dart';

class ProgressPopup extends StatelessWidget {
  const ProgressPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final containerWidth = screenWidth * 0.9;
    final containerPadding = screenWidth * 0.04; // Responsive padding
    final titleFontSize = screenWidth * 0.045; // Responsive title font size
    final headerFontSize = screenWidth * 0.035; // Responsive header font size
    final bodyFontSize = screenWidth * 0.03; // Responsive body font size
    final innerPadding = screenWidth * 0.04; // Responsive inner padding
    final verticalPadding = screenHeight * 0.01; // Responsive vertical padding
    final spacing1 = screenHeight * 0.015; // Responsive spacing
    final spacing2 = screenHeight * 0.01; // Responsive spacing
    final spacing3 = screenHeight * 0.008; // Responsive spacing
    final lockIconSize = screenWidth * 0.05; // Responsive lock icon size
    final closeIconSize = screenWidth * 0.06; // Responsive close icon size

    // Calculate minimum required height (simplified)
    final estimatedTitleHeight = titleFontSize * 2.5; // Estimate title height
    final estimatedHeaderRowHeight = headerFontSize * 1.5; // Estimate header row height
    final estimatedStatusRowHeight = (estimatedHeaderRowHeight + bodyFontSize * 2 + spacing3) * 1.2; // Estimate status row height
    final estimatedLockedSessionHeight = headerFontSize * 1.5; // Estimate locked session height
    final totalLockedSessionsHeight = estimatedLockedSessionHeight * 3; // 3 locked sessions
    final totalSpacing = spacing1 + spacing2 + (spacing3 * 2); // Various spacings
    final totalInnerPadding = verticalPadding * 2;
    final minInnerHeight =
        estimatedTitleHeight +
        estimatedStatusRowHeight +
        totalLockedSessionsHeight +
        totalSpacing +
        totalInnerPadding;

    // Calculate total popup height (simplified)
    final estimatedHeaderHeight = screenHeight * 0.06; // Estimate header height
    final outerSpacing = spacing1;
    final totalOuterPadding = containerPadding * 2;
    final minTotalHeight =
        estimatedHeaderHeight + minInnerHeight + outerSpacing + totalOuterPadding;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
    final containerHeight =
        (minTotalHeight > screenHeight * 0.8)
            ? screenHeight * 0.8
            : (minTotalHeight < screenHeight * 0.5 ? screenHeight * 0.5 : minTotalHeight); // Added a minimum height

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 5, 14, 22),
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01), // Responsive padding
                  child: Center(
                    child: Text(
                      "Track Your ZEROKOIN\nProgress",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize, // Responsive font size
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                iconSize: closeIconSize, // Responsive icon size
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: spacing1), // Responsive spacing
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff5D5454),
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: innerPadding, // Responsive padding
                    vertical: verticalPadding, // Responsive padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Session 1",
                            style: TextStyle(
                              fontSize: headerFontSize, // Responsive font size
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing2), // Responsive spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                              children: [
                                Text(
                                  "Session",
                                  style: TextStyle(
                                    fontSize: headerFontSize, // Responsive font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: spacing3), // Responsive spacing
                                Text(
                                  "Active",
                                  style: TextStyle(
                                    fontSize: bodyFontSize, // Responsive font size
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: headerFontSize, // Responsive font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: spacing3), // Responsive spacing
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: bodyFontSize, // Responsive font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    fontSize: headerFontSize, // Responsive font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: spacing3), // Responsive spacing
                                Text(
                                  "2 Hours Remaining",
                                  style: TextStyle(
                                    fontSize: bodyFontSize, // Responsive font size
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing2), // Responsive spacing
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(
                            3,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: spacing3), // Responsive vertical padding
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/lock.png"),
                                    height: lockIconSize, // Responsive icon size
                                    width: lockIconSize, // Responsive icon size
                                  ),
                                  SizedBox(width: screenWidth * 0.02), // Responsive spacing
                                  Text(
                                    "Session ${index + 2} Locked",
                                    style: TextStyle(
                                      fontSize: headerFontSize, // Responsive font size
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
