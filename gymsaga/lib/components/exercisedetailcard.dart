import 'package:flutter/material.dart';

class ExerciseDetailCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String reps;
  final VoidCallback onStart;

  const ExerciseDetailCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.reps,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD185),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade800, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.shade200,
                  offset: const Offset(4, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'Jersey25',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    reps,
                    style: const TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: onStart,
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/widgets/buttons/golden_button.png'),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: const Alignment(0, -0.7),
              child: const Text(
                'START',
                style: TextStyle(
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
        ],
      ),
    );
  }
}
