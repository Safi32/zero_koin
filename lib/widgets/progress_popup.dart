import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPopup extends StatefulWidget {
  final int sessionIndex;
  const ProgressPopup({super.key, this.sessionIndex = 1});

  @override
  State<ProgressPopup> createState() => _ProgressPopupState();
}

class _ProgressPopupState extends State<ProgressPopup> {
  Timer? _timer;
  int _remainingSeconds = 5; // 5 seconds for testing
  bool _isTimerRunning = false;
  bool _isClaimed = false;
  static const int _totalSeconds = 5; // 5 seconds total

  @override
  void initState() {
    super.initState();
    _loadTimerState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEndTime = prefs.getInt('session_${widget.sessionIndex}_timer_end_time');
    final claimed = prefs.getBool('session_${widget.sessionIndex}_claimed') ?? false;

    setState(() {
      _isClaimed = claimed;
    });

    if (savedEndTime != null && !claimed) {
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final remaining = savedEndTime - currentTime;

      if (remaining > 0) {
        setState(() {
          _remainingSeconds = remaining;
          _isTimerRunning = true;
        });
        _startTimer();
      } else {
        // Timer has expired, can be claimed
        setState(() {
          _remainingSeconds = 0;
          _isTimerRunning = false;
        });
      }
    } else if (!claimed) {
      // No saved timer and not claimed, start a new timer automatically
      _startTimer();
    }
  }

  void _startTimer() {
    if (!_isTimerRunning && _remainingSeconds > 0 && !_isClaimed) {
      setState(() {
        _isTimerRunning = true;
      });
      _saveTimerState();

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _stopTimer();
          }
        });
      });
    }
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _timer?.cancel();
    _saveTimerState();
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isTimerRunning && _remainingSeconds > 0) {
      final endTime = (DateTime.now().millisecondsSinceEpoch ~/ 1000) + _remainingSeconds;
      await prefs.setInt('session_${widget.sessionIndex}_timer_end_time', endTime);
    }
    await prefs.setBool('session_${widget.sessionIndex}_claimed', _isClaimed);
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}HR ${minutes}MIN Remaining';
    } else {
      return '${minutes}MIN Remaining';
    }
  }

  String get _statusText {
    if (_isClaimed) {
      return 'Claimed';
    } else if (_remainingSeconds == 0) {
      return 'Ready to Claim';
    } else {
      return 'Progress';
    }
  }

  String get _timeText {
    // Always show the timer countdown, regardless of claimed status
    if (_remainingSeconds == 0) {
      return 'Timer Complete';
    } else {
      return _formatTime(_remainingSeconds);
    }
  }

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
                            "Session ${widget.sessionIndex}",
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
                                  _statusText,
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
                                  _timeText,
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
