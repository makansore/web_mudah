import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'finishresetpass.dart';

class SettingUpYourNewPasswordScreen extends StatefulWidget {
  const SettingUpYourNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SettingUpYourNewPasswordScreen> createState() =>
      _SettingUpYourNewPasswordScreenState();
}

class _SettingUpYourNewPasswordScreenState
    extends State<SettingUpYourNewPasswordScreen> {
  bool showComplete = false;
  Timer? _dotTimer;

  @override
  void initState() {
    super.initState();

    // Delayed navigation to FinishResetPass
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showComplete = true;
        });

        // Navigate to FinishResetPass after a short delay to show completion
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const FinishResetPassScreen()),
          );
        });
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
      backgroundColor: const Color(
          0xFFF9DEAF), // Light yellow background to match other screens
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!showComplete)
              const Text(
                'Setting up your\nnew password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey25',
                  color: Color(0xFFF3A737),
                  fontSize: 36,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3.0,
                      color: Color.fromARGB(120, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            if (!showComplete) const SizedBox(height: 16),
            if (!showComplete)
              const Text(
                'please wait',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            if (!showComplete) const SizedBox(height: 20),
            if (!showComplete)
              const SizedBox(
                height: 50,
                width: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Colors.black],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent,
                ),
              ),
            AnimatedOpacity(
              opacity: showComplete ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: const Text(
                'Complete!',
                style: TextStyle(
                  fontSize: 36,
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