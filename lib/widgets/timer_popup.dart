import 'package:flutter/material.dart';
import 'package:zero_koin/widgets/pop_up_button.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:zero_koin/widgets/earn_rewards.dart';
import 'dart:ui';
import 'dart:async';
import 'package:zero_koin/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerPopup extends StatefulWidget {
  final int sessionIndex;
  const TimerPopup({super.key, this.sessionIndex = 1});

  @override
  State<TimerPopup> createState() => _TimerPopupState();
}

class _TimerPopupState extends State<TimerPopup> {
  final UserController _userController = Get.find<UserController>();
  Timer? _timer;
  int _remainingSeconds = 5; // 5 seconds for testing
  bool _isTimerRunning = false;
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

    if (savedEndTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final remaining = savedEndTime - currentTime;

      if (remaining > 0) {
        setState(() {
          _remainingSeconds = remaining;
          _isTimerRunning = true;
        });
        _startTimer();
      } else {
        // Timer has expired
        setState(() {
          _remainingSeconds = 0;
          _isTimerRunning = false;
        });
        await prefs.remove('session_${widget.sessionIndex}_timer_end_time');
      }
    } else {
      // No saved timer, start a new timer automatically
      _startTimer();
    }
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isTimerRunning && _remainingSeconds > 0) {
      final endTime = (DateTime.now().millisecondsSinceEpoch ~/ 1000) + _remainingSeconds;
      await prefs.setInt('session_${widget.sessionIndex}_timer_end_time', endTime);
    } else {
      await prefs.remove('session_${widget.sessionIndex}_timer_end_time');
    }
  }

  void _startTimer() {
    if (!_isTimerRunning && _remainingSeconds > 0) {
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

  void _resetTimer() {
    setState(() {
      _remainingSeconds = _totalSeconds;
      _isTimerRunning = false;
    });
    _timer?.cancel();
    _saveTimerState();
    // Clear claimed state for new timer cycle
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('timer_claimed', false);
    });
  }

  void _markAsClaimed() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('session_${widget.sessionIndex}_claimed', true);
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    return '${hours}HR ${minutes}MIN';
  }

  String get _titleText {
    if (_remainingSeconds == 0) {
      return 'Timer Complete';
    } else if (_isTimerRunning) {
      return 'Timer Running';
    } else {
      return 'Timer Start';
    }
  }

  double get _progress {
    if (_totalSeconds == 0) return 0.0;
    return _remainingSeconds / _totalSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final containerWidth = screenWidth * 0.8;
    final containerPadding = screenWidth * 0.05; // Responsive padding
    final titleFontSize = screenWidth * 0.055; // Responsive title font size
    final circleRadius = screenWidth * 0.2; // Radius of the circle
    final strokeWidth = screenWidth * 0.03; // Thickness of the circle stroke
    final mainTextFontSize = screenWidth * 0.06; // Font size for "68.3 90"
    final subTextFontSize = screenWidth * 0.035; // Font size for "3HR 35 MIN"

    final verticalSpacing1 = screenHeight * 0.015; // Responsive spacing
    final verticalSpacing2 = screenHeight * 0.02; // Responsive spacing
    final buttonHeight = screenHeight * 0.06; // Responsive button height
    final buttonTextFontSize = screenWidth * 0.04; // Responsive button text font size

    // Calculate minimum required height (simplified)
    final titleHeight = titleFontSize * 1.2; // Approximate height for title
    final circleDiameter = (circleRadius + strokeWidth / 2) * 2; // Diameter of the circle including stroke
    final totalSpacing = verticalSpacing1 + verticalSpacing2; // 2 spacing elements
    final totalPadding = containerPadding * 2; // Top and bottom padding
    final minRequiredHeight = titleHeight + circleDiameter + buttonHeight + totalSpacing + totalPadding;

    // Use calculated height but ensure it doesn't exceed screen bounds and has a minimum
    final containerHeight =
        (minRequiredHeight > screenHeight * 0.8)
            ? screenHeight * 0.8
            : (minRequiredHeight < screenHeight * 0.3 ? screenHeight * 0.3 : minRequiredHeight);

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Responsive border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                _titleText,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: verticalSpacing1),
          Flexible(
            child: SizedBox(
              width: circleDiameter,
              height: circleDiameter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(circleDiameter, circleDiameter),
                    painter: CircularProgressPainter(
                      progress: _progress,
                      strokeWidth: strokeWidth,
                      gradientColors: [Color(0xFF0682A2), Color(0xFFC5C113)],
                      backgroundColor: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Text(
                        "${_userController.balance.value}",
                        style: TextStyle(
                          fontSize: mainTextFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                      Text(
                        _remainingSeconds == 0 ? "0HR 0MIN" : _formatTime(_remainingSeconds),
                        style: TextStyle(
                          fontSize: subTextFontSize,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: verticalSpacing2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PopUpButton(
                  buttonText: "Claim",
                  buttonColor: const Color(0xFF0682A2),
                  onPressed: () {
                    // Allow claiming at any time during the 6-hour period
                    _markAsClaimed(); // Mark as claimed
                    Navigator.of(context).pop(); // Dismiss TimerPopup
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
                            child: EarnRewards(),
                          ),
                        );
                      },
                    );
                  },
                  textColor: Colors.white,
                  borderColor: Colors.transparent,
                  fontSize: buttonTextFontSize, // Use responsive font size
                ),
              ),
              SizedBox(width: screenWidth * 0.03), // Responsive spacing between buttons
              Expanded(
                child: PopUpButton(
                  buttonText: "Boost",
                  buttonColor: Colors.white,
                  onPressed: () {},
                  textColor: Colors.black,
                  borderColor: const Color(0xFF0682A2),
                  fontSize: buttonTextFontSize, // Use responsive font size
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> gradientColors;
  final Color backgroundColor;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradientColors,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - strokeWidth / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2, // Start from top
      endAngle: -math.pi / 2 + (2 * math.pi * progress), // End based on progress
      colors: gradientColors,
      tileMode: TileMode.repeated,
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Use round caps for a smoother look

    canvas.drawArc(
      rect,
      -math.pi / 2, // Start angle (top)
      2 * math.pi * progress, // Sweep angle
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
