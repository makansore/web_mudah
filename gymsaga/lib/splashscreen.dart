import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  bool showLogoAndTitle = false; // untuk slide + fade
  bool showTagline = false; // fade tagline

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Slide ke page 2
    Future.delayed(const Duration(milliseconds: 800), () {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    // logo + GYM SAGA
    Future.delayed(const Duration(milliseconds: 1300), () {
      setState(() {
        showLogoAndTitle = true;
      });
    });

    // LEVEL UP YOUR BODY
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        showTagline = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBE3B3),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Splash 1 - Kosong
          Container(color: const Color(0xFFFBE3B3)),

          // Splash 2 & 3
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO - Slide
                AnimatedSlide(
                  offset: showLogoAndTitle ? Offset.zero : const Offset(0, 0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    'assets/widgets/images/logo.png',
                    width: 500,
                    height: 250,
                  ),
                ),

                const SizedBox(height: 20),

                // GYM SAGA - Fade in
                AnimatedOpacity(
                  opacity: showLogoAndTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    'assets/widgets/images/gymsaga.png',
                    width: 300,
                  ),
                ),

                const SizedBox(height: 10),

                // LEVEL UP - Fade in
                AnimatedOpacity(
                  opacity: showTagline ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 900),
                  child: Image.asset(
                    'assets/widgets/images/levelup.png',
                    width: 300,
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
