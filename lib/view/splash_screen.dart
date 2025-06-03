import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zero_koin/view/user_registeration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _zoomController;
  late Animation<double> _glowAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _glowIntensityAnimation;

  @override
  void initState() {
    super.initState();

    // Enhanced glow animation - matches HTML CSS glow effect
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 5.0, end: 20.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _glowIntensityAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Enhanced zoom animation - matches HTML CSS zoom effect
    _zoomController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    // Navigate to next screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const UserRegisterationScreen());
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar content to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Background.jpg', fit: BoxFit.cover),
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _glowAnimation,
                _zoomAnimation,
                _glowIntensityAnimation,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _zoomAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glowing background circle - like your reference
                      Container(
                        width: 200 + _glowAnimation.value * 4,
                        height: 200 + _glowAnimation.value * 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withValues(
                                alpha: _glowIntensityAnimation.value * 0.3,
                              ),
                              Colors.white.withValues(
                                alpha: _glowIntensityAnimation.value * 0.15,
                              ),
                              Colors.white.withValues(
                                alpha: _glowIntensityAnimation.value * 0.05,
                              ),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                      // Additional outer glow for more intensity
                      Container(
                        width: 300 + _glowAnimation.value * 6,
                        height: 300 + _glowAnimation.value * 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withValues(
                                alpha: _glowIntensityAnimation.value * 0.1,
                              ),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 1.0],
                          ),
                        ),
                      ),
                      // The actual logo on top
                      Image.asset(
                        'assets/bluelogo.png',
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Copyright text at the bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '© 2024 - 2025 Zero Koin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Learn and Earn Crypto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
