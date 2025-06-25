import 'package:flutter/material.dart';
import 'package:zero_koin/constant/app_colors.dart';
import 'package:zero_koin/widgets/gift_popup.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:zero_koin/widgets/timer_popup.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_koin/services/notification_service.dart';

class SessionPopup extends StatefulWidget {
  const SessionPopup({super.key});

  @override
  State<SessionPopup> createState() => _SessionPopupState();
}

class _SessionPopupState extends State<SessionPopup> {
  int? _activeSessionIndex;
  Timer? _timer;
  Map<int, bool> _sessionCompleted = {1: false, 2: false, 3: false, 4: false};
  Map<int, int> _sessionTimers = {1: 5, 2: 5, 3: 5, 4: 5}; // 5 seconds each for testing

  @override
  void initState() {
    super.initState();
    _loadSessionStates();
    _startTimerCheck();

    // Trigger notification when popup is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerSessionUnlockedNotification();
    });
  }

  Future<void> _triggerSessionUnlockedNotification() async {
    try {
      final notificationService = Get.find<NotificationService>();
      await notificationService.showSessionUnlockedNotification();
    } catch (e) {
      print('Error triggering notification: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSessionStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sessionCompleted[1] = prefs.getBool('session_1_completed') ?? false;
      _sessionCompleted[2] = prefs.getBool('session_2_completed') ?? false;
      _sessionCompleted[3] = prefs.getBool('session_3_completed') ?? false;
      _sessionCompleted[4] = prefs.getBool('session_4_completed') ?? false;
    });
  }

  void _startTimerCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final prefs = await SharedPreferences.getInstance();

      // Check each session's timer
      for (int sessionIndex = 1; sessionIndex <= 4; sessionIndex++) {
        final savedEndTime = prefs.getInt('session_${sessionIndex}_timer_end_time');

        if (savedEndTime != null && !_sessionCompleted[sessionIndex]!) {
          final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
          final remaining = savedEndTime - currentTime;

          // Check if this session timer has completed
          if (remaining <= 0) {
            await _completeSession(sessionIndex);
          }
        }
      }
    });
  }

  Future<void> _completeSession(int sessionIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('session_${sessionIndex}_completed', true);

    setState(() {
      _sessionCompleted[sessionIndex] = true;
    });

    // If Session 4 is completed, reset all sessions after a short delay
    if (sessionIndex == 4) {
      await Future.delayed(Duration(seconds: 2)); // Give user time to see completion
      await _resetAllSessions();
    }
  }

  Future<void> _resetAllSessions() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all session completion states
    for (int i = 1; i <= 4; i++) {
      await prefs.remove('session_${i}_completed');
      await prefs.remove('session_${i}_timer_end_time');
      await prefs.remove('session_${i}_claimed');
    }

    // Reset local state
    setState(() {
      _sessionCompleted = {1: false, 2: false, 3: false, 4: false};
      _activeSessionIndex = null;
    });
  }

  bool _isSessionEnabled(int sessionIndex) {
    // If this session is already completed, disable it
    if (_sessionCompleted[sessionIndex] ?? false) {
      return false;
    }

    if (sessionIndex == 1) return true; // Session 1 is always enabled initially

    // Enable next session only if previous session is completed
    return _sessionCompleted[sessionIndex - 1] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final containerWidth = screenWidth * 0.8;
    final containerPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.04;
    final sessionButtonHeight = screenHeight * 0.07;
    final sessionFontSize = screenWidth * 0.045;
    final verticalSpacing = screenHeight * 0.015;
    final closeIconSize = screenWidth * 0.06;

    // Calculate minimum required height (simplified)
    final headerHeight = screenHeight * 0.05; // Estimate header height
    final totalSessionsHeight = sessionButtonHeight * 4; // 4 session buttons
    final totalSpacing = verticalSpacing * 5; // 5 spacing elements
    final totalPadding = containerPadding * 2; // Top and bottom padding
    final minRequiredHeight = headerHeight + totalSessionsHeight + totalSpacing + totalPadding;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
     final containerHeight =
        (minRequiredHeight > screenHeight * 0.8)
            ? screenHeight * 0.8
            : (minRequiredHeight < screenHeight * 0.4 ? screenHeight * 0.4 : minRequiredHeight);

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
                  padding: EdgeInsets.only(top: screenHeight * 0.01), // Adjust padding
                  child: Center(
                    child: Text(
                      "Complete your session\nevery 6 hours",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
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
          SizedBox(height: verticalSpacing),
          GestureDetector(
            onTap: _isSessionEnabled(1) ? () async {
              setState(() {
                _activeSessionIndex = 1;
              });
              Navigator.of(context).pop(); // Dismiss SessionPopup

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: GiftPopup(),
                      ),
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 2));
                Navigator.of(Get.context!, rootNavigator: true).pop(); // Dismiss GiftPopup

                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: TimerPopup(sessionIndex: 1),
                      ),
                    );
                  },
                );
              });
            } : null,
            child: Container(
              width: double.infinity,
              height: sessionButtonHeight,
              decoration: BoxDecoration(
                color: _sessionCompleted[1] ?? false
                    ? const Color(0xFF0682A2) // Completed sessions are blue
                    : _isSessionEnabled(1)
                        ? (_activeSessionIndex == 1 ? const Color(0xFF0682A2) : Colors.grey)
                        : Colors.grey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sessionCompleted[1] ?? false ? "Session 1 - Completed" : "Session 1",
                      style: TextStyle(
                        fontSize: sessionFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Image.asset(
                      "assets/session_clock.png",
                      height: sessionFontSize, // Responsive image size based on text
                      width: sessionFontSize, // Responsive image size based on text
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          GestureDetector(
            onTap: _isSessionEnabled(2) ? () async {
              setState(() {
                _activeSessionIndex = 2;
              });
              Navigator.of(context).pop(); // Dismiss SessionPopup

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: GiftPopup(),
                      ),
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 2));
                Navigator.of(Get.context!, rootNavigator: true).pop(); // Dismiss GiftPopup

                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: TimerPopup(sessionIndex: 2),
                      ),
                    );
                  },
                );
              });
            } : null,
            child: Container(
              width: double.infinity,
              height: sessionButtonHeight,
              decoration: BoxDecoration(
                color: _sessionCompleted[2] ?? false
                    ? const Color(0xFF0682A2) // Completed sessions are blue
                    : _isSessionEnabled(2)
                        ? (_activeSessionIndex == 2 ? const Color(0xFF0682A2) : Colors.grey)
                        : Colors.grey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sessionCompleted[2] ?? false ? "Session 2 - Completed" : "Session 2",
                      style: TextStyle(
                        fontSize: sessionFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Image.asset(
                      "assets/session_clock.png",
                       height: sessionFontSize, // Responsive image size based on text
                      width: sessionFontSize, // Responsive image size based on text
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          GestureDetector(
            onTap: _isSessionEnabled(3) ? () async {
              setState(() {
                _activeSessionIndex = 3;
              });
              Navigator.of(context).pop(); // Dismiss SessionPopup

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: GiftPopup(),
                      ),
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 2));
                Navigator.of(Get.context!, rootNavigator: true).pop(); // Dismiss GiftPopup

                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: TimerPopup(sessionIndex: 3),
                      ),
                    );
                  },
                );
              });
            } : null,
            child: Container(
              width: double.infinity,
              height: sessionButtonHeight,
              decoration: BoxDecoration(
                color: _sessionCompleted[3] ?? false
                    ? const Color(0xFF0682A2) // Completed sessions are blue
                    : _isSessionEnabled(3)
                        ? (_activeSessionIndex == 3 ? const Color(0xFF0682A2) : Colors.grey)
                        : Colors.grey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sessionCompleted[3] ?? false ? "Session 3 - Completed" : "Session 3",
                      style: TextStyle(
                        fontSize: sessionFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Image.asset(
                      "assets/session_clock.png",
                       height: sessionFontSize, // Responsive image size based on text
                      width: sessionFontSize, // Responsive image size based on text
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          GestureDetector(
            onTap: _isSessionEnabled(4) ? () async {
              setState(() {
                _activeSessionIndex = 4;
              });
              Navigator.of(context).pop(); // Dismiss SessionPopup

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: GiftPopup(),
                      ),
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 2));
                Navigator.of(Get.context!, rootNavigator: true).pop(); // Dismiss GiftPopup

                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: TimerPopup(sessionIndex: 4),
                      ),
                    );
                  },
                );
              });
            } : null,
            child: Container(
              width: double.infinity,
              height: sessionButtonHeight,
              decoration: BoxDecoration(
                color: _sessionCompleted[4] ?? false
                    ? const Color(0xFF0682A2) // Completed sessions are blue
                    : _isSessionEnabled(4)
                        ? (_activeSessionIndex == 4 ? const Color(0xFF0682A2) : Colors.grey)
                        : Colors.grey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sessionCompleted[4] ?? false ? "Session 4 - Completed" : "Session 4",
                      style: TextStyle(
                        fontSize: sessionFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Image.asset(
                      "assets/session_clock.png",
                      height: sessionFontSize, // Responsive image size based on text
                      width: sessionFontSize, // Responsive image size based on text
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
