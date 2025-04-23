import 'package:flutter/material.dart';
import '../navbar.dart';
import 'dart:async';

class ExerciseTimerPage extends StatefulWidget {
  final VoidCallback onContinue;
  const ExerciseTimerPage({super.key, required this.onContinue});

  @override
  State<ExerciseTimerPage> createState() => _ExerciseTimerPageState();
}

class _ExerciseTimerPageState extends State<ExerciseTimerPage> {
  Map<int, bool> isSetStarted = {1: false, 2: false, 3: false};
  Map<int, bool> isSetFinished = {1: false, 2: false, 3: false};
  Map<int, int> remainingMilliseconds = {
    1: 5000,
    2: 5000,
    3: 5000,
  };
  Map<int, dynamic> timers = {1: null, 2: null, 3: null};
  bool showCongratulations = false;

  @override
  void dispose() {
    timers.forEach((set, timer) {
      if (timer is Timer && timer.isActive) {
        timer.cancel();
      }
    });
    super.dispose();
  }

  void startTimer(int setNumber) {
    if (isSetFinished[setNumber] == true) return;

    if (isSetStarted[setNumber] == true) {
      timers[setNumber]?.cancel();
      remainingMilliseconds[setNumber] = 120000;
    }

    setState(() {
      isSetStarted[setNumber] = true;
    });

    timers[setNumber] =
        Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      setState(() {
        if (remainingMilliseconds[setNumber]! > 0) {
          remainingMilliseconds[setNumber] =
              remainingMilliseconds[setNumber]! - 10;
        } else {
          timer.cancel();
          isSetFinished[setNumber] = true;

          if (isSetFinished[1]! && isSetFinished[2]! && isSetFinished[3]!) {
            showCongratulations = true;
          }
        }
      });
    });
  }

  String formatTime(int totalMilliseconds) {
    int minutes = (totalMilliseconds ~/ 60000) % 60;
    int seconds = (totalMilliseconds ~/ 1000) % 60;
    int milliseconds = totalMilliseconds % 1000;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${(milliseconds ~/ 10).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                color: const Color(0xFFFFE9B2),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'TIMER',
                          style: TextStyle(
                            fontFamily: 'Jersey25',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 56),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 80,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      buildSetSection(1),
                      const SizedBox(height: 24),
                      buildSetSection(2),
                      const SizedBox(height: 24),
                      buildSetSection(3),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            if (showCongratulations)
              Positioned(
                left: 0,
                right: 0,
                bottom: kBottomNavigationBarHeight,
                child: buildCongratulationsPopup(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget buildSetSection(int setNumber) {
    bool isFinished = isSetFinished[setNumber] ?? false;

    return Column(
      children: [
        Text(
          'SET $setNumber',
          style: const TextStyle(
            fontFamily: 'Jersey25',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
            child: Text(
              'Rest Timer',
              style: TextStyle(
                fontFamily: 'Jersey25',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE9B2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Center(
            child: Text(
              formatTime(remainingMilliseconds[setNumber]!),
              style: const TextStyle(
                fontFamily: 'Jersey25',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: isFinished ? null : () => startTimer(setNumber),
          child: Opacity(
            opacity: isFinished ? 0.5 : 1.0,
            child: Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/widgets/buttons/golden_button.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              alignment: const Alignment(0, -0.7),
              child: Text(
                isFinished ? 'FINISHED' : 'START',
                style: const TextStyle(
                  fontFamily: 'Jersey25',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCongratulationsPopup() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD185),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CONGRATULATIONS\nON FINISHING',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey25',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const Text(
                'YOUR WORKOUT!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey25',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/widgets/images/dumbell_image.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.onContinue(); // Navigasi ke exercise selanjutnya
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/widgets/buttons/golden_button.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  alignment: const Alignment(0, -0.7),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
