import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'finishsettingup.dart';

class SettingUpScreen extends StatefulWidget {
  const SettingUpScreen({Key? key}) : super(key: key);

  @override
  State<SettingUpScreen> createState() => _SettingUpScreenState();
}

class _SettingUpScreenState extends State<SettingUpScreen> {
  String baseText = "SETTING IT UP";
  String loadingDots = "";
  int dotCount = 0;
  Timer? _dotTimer;
  bool showComplete = false;

  @override
  void initState() {
    super.initState();
    // Timer untuk animasi dot loading
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
        loadingDots = "." * dotCount;
      });
    });

    // Delayed navigation to FinishSettingUp
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showComplete = true;
        });

        // Cancel the dot timer
        _dotTimer?.cancel();

        // Navigate to FinishSettingUp
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FinishSettingUp()),
        );
      }
    });
  }

  @override
  void dispose() {
    _dotTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6DC), // Light yellow background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!showComplete)
              Text(
                '$baseText$loadingDots',
                style: const TextStyle(
                  fontFamily: 'Jersey25',
                  color: Color(0xFFF3A737),
                  fontSize: 60,
                  letterSpacing: 2,
                ),
              ),
            if (!showComplete) const SizedBox(height: 16),
            if (!showComplete)
              const Text(
                'Please wait',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Jersey25',
                ),
              ),
            if (!showComplete) const SizedBox(height: 40),
            if (!showComplete)
              const SizedBox(
                height: 60,
                width: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Colors.black], // Changed to black
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent,
                ),
              ),
            //  "Loading Complete"
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: showComplete ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: const Text(
                'Loading Complete',
                style: TextStyle(
                  fontSize: 48,
                  color: Color(0xFFF3A737),
                  fontFamily: 'Jersey25',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
