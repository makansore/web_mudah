import 'package:flutter/material.dart';
import '../navbar.dart';

class ExerciseFinishedCard extends StatefulWidget {
  final VoidCallback onComplete;

  const ExerciseFinishedCard({super.key, required this.onComplete});

  @override
  State<ExerciseFinishedCard> createState() => _ExerciseFinishedCardState();
}

class _ExerciseFinishedCardState extends State<ExerciseFinishedCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset('assets/widgets/background/decor_atas.png'),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/widgets/background/header.png'),
            ),
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  'Workout',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Jersey25',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // ✅ Container gerakan dengan red bar
            Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  buildFinishedExerciseBox("Pushups – 3 x 10–20 Reps"),
                  const SizedBox(height: 12),
                  buildFinishedExerciseBox("Pike Pushups – 3 x 10–12 Reps"),
                  const SizedBox(height: 12),
                  buildFinishedExerciseBox("Pike Pushups – 3 x 10–12 Reps"),
                  const SizedBox(height: 12),
                  buildFinishedExerciseBox("Dips – 3 x 10–15 Reps"),
                ],
              ),
            ),

            // ✅ Rewards dan Complete button
            Positioned(
              top: 500,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rewards',
                    style: TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 24,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9B2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    '+120 XP',
                                    style: TextStyle(
                                      fontFamily: 'Jersey25',
                                      fontSize: 20,
                                      color: Color(0xFF38B6FF),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    '🔥 200 KCAL',
                                    style: TextStyle(
                                      fontFamily: 'Jersey25',
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '+ Explosive Strength',
                                  style: TextStyle(
                                    fontFamily: 'Jersey25',
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '+ Upper body strength',
                                  style: TextStyle(
                                    fontFamily: 'Jersey25',
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: GestureDetector(
                      onTap: widget.onComplete,
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/widgets/buttons/golden_button.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: const Alignment(0, -0.7),
                        child: const Text(
                          'COMPLETE',
                          style: TextStyle(
                            fontFamily: 'Jersey25',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget buildFinishedExerciseBox(String text) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 70, // ✅ ukuran container diperbesar
          decoration: BoxDecoration(
            color: Colors.brown[100]?.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Jersey25',
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
        ),
        Positioned(
          top: 27, // ✅ Redbar diposisikan di tengah container (70px / 2 - 8px)
          left: 0,
          right: 0,
          child: SizedBox(
            height: 16, // ✅ redbar tipis
            child: Image.asset(
              'assets/widgets/images/redbar.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
