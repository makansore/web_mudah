import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String baseText = "LOADING";
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

    // tampilkan "Loading Complete"
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showComplete = true;
      });

      // selesai loading
      _dotTimer?.cancel();
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
      backgroundColor: Colors.black,
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
                'Your account is currently being Check up.',
                style: TextStyle(
                  color: Colors.white,
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
                  colors: [Colors.white],
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
