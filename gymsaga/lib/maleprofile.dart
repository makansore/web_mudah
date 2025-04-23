import 'package:flutter/material.dart';
import 'weightgoal.dart';

class MaleProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'What\'s your goal?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/widgets/images/male_lose_weight.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                _buildButton('LOSE WEIGHT', context),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/widgets/images/male_build_muscle.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                _buildButton('BUILD MUSCLE', context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeightGoal()),
        );
      },
      child: Container(
        height: 50,
        width: 240,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/widgets/buttons/golden_button.png'),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Transform.translate(
          offset: const Offset(0, -8),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
