import 'package:flutter/material.dart';
import 'settingup.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                // Title
                const Text(
                  'ENABLE PHYSICAL ACTIVITY',
                  style: TextStyle(
                    fontFamily: 'Jersey25',
                    fontSize: 30,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                // Location Icon
                Image.asset(
                  'assets/widgets/images/activity_tracker.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                // Running Figures
                Image.asset(
                  'assets/widgets/images/activity_running.png',
                  width: 200,
                  height: 100,
                ),
                const SizedBox(height: 30),
                // Explanation Text
                const Text(
                  'Please allow us to access your physical activity',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                // Enable Permission Button
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingUpScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 240,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/widgets/buttons/golden_button.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: const Offset(0, -8),
                      child: const Text(
                        'ENABLE PERMISSION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Not Now Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'NOT NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
