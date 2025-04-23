import 'package:flutter/material.dart';
import 'navbar.dart';
import 'editprofile.dart';
import 'workout_history.dart';
import 'myweight.dart';
import 'stat_calories.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: SafeArea(
        child: Stack(
          children: [
            // Decor overlay right under header
            Positioned(
              top: 80, // adjust based on height of header.png
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/widgets/background/decor_atas.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Background Header Image (fixed at the top)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/widgets/background/header.png',
                fit: BoxFit.cover,
              ),
            ),

            // Centered "PROFILE" Text
            Positioned(
              top: 24, // adjust vertically as needed
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  children: [
                    // Text outline
                    Text(
                      'PROFILE',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jersey25',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    // Text fill with shadow
                    Text(
                      'PROFILE',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jersey25',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 5),
                            blurRadius: 0,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Gear Icon on the right
            Positioned(
              top: 32, // same vertical as text for alignment
              right: 16,
              child: Icon(
                Icons.settings,
                color: Colors.black,
                size: 28,
                shadows: [
                  Shadow(
                    offset: Offset(0, 3),
                    blurRadius: 0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Actual page content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 160), // make space for background
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage(
                            'assets/widgets/images/female_profile.png',
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Katie',
                              style: const TextStyle(
                                fontSize: 42,
                                fontFamily: 'Jersey25',
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/widgets/buttons/edit_button.png',
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        ProfileStat(label: 'Start Weight', value: '60.4 KG'),
                        ProfileStat(label: 'Goal', value: '50.0 KG'),
                        ProfileStat(label: 'Daily Calories', value: '594 kcal'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProfileButton(
                    label: 'My Weight',
                    icon: Icons.monitor_weight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyWeightPage(),
                        ),
                      );
                    },
                  ),
                  ProfileButton(
                    label: 'Workout History',
                    icon: Icons.fitness_center,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorkoutHistoryPage(),
                        ),
                      );
                    },
                  ),
                  ProfileButton(
                    label: 'Statistics',
                    icon: Icons.show_chart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatCaloriesPage(),
                        ),
                      );
                    },
                  ),
                  const ProfileButton(
                      label: 'Achievements', icon: Icons.emoji_events),
                  const SizedBox(height: 80), // Extra space for navbar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 3),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/widgets/background/profile_frame.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 300,
          height: 100,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/widgets/background/frame.png'),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: 'Jersey25',
                  ),
                ),
              ),
              Image.asset(
                'assets/widgets/buttons/right_chevron.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
