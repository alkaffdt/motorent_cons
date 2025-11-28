import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motorent_cons/consts/app_assets_const.dart';
import 'package:motorent_cons/core/app_router.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _fadeLogo;
  late Animation<double> _scaleLogo;

  late Animation<double> _fadeText;
  late Animation<Offset> _slideText;

  @override
  void initState() {
    super.initState();

    // Logo Animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeLogo = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _scaleLogo = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Text Animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeText = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _slideText = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Start animations with delay
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });

    // Navigate to next screen
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRouter.home);
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1717), // Electrum dark theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGO ANIMATION
            FadeTransition(
              opacity: _fadeLogo,
              child: ScaleTransition(
                scale: _scaleLogo,
                child: Image.asset(AppAssetsConst.logo, width: 140),
              ),
            ),

            20.toHeightGap(),

            Text(
              'MotoRENT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            20.toHeightGap(),

            // TAGLINE ANIMATION
            FadeTransition(
              opacity: _fadeText,
              child: SlideTransition(
                position: _slideText,
                child: const Text(
                  "Powering Your Ride",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
