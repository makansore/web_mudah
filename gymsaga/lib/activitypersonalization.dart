import 'package:flutter/material.dart';
import 'permission.dart';

class ActivityPersonalization extends StatelessWidget {
  const ActivityPersonalization({Key? key}) : super(key: key);

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
                  'What\'s your activity level?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildActivityButton(
                  context,
                  'assets/widgets/images/activity_level_1.png',
                  'I sit in my desk all day',
                ),
                const SizedBox(height: 20),
                _buildActivityButton(
                  context,
                  'assets/widgets/images/activity_level_2.png',
                  'I walk occasionally for 30m',
                ),
                const SizedBox(height: 20),
                _buildActivityButton(
                  context,
                  'assets/widgets/images/activity_level_3.png',
                  'I spend at least an hour working out',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(
    BuildContext context,
    String imagePath,
    String text,
  ) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PermissionPage()),
            );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/widgets/buttons/golden_button.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
