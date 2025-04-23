import 'package:flutter/material.dart';
import 'navbar.dart';
import 'pushdaypage/pushup.dart';
import 'coredaypage/plank.dart';
import 'legsdaypage/squats.dart';
import 'armdaypage/shoulderpress.dart';
import 'pulldaypage/bodyweightrows.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key}) : super(key: key);

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
              child: Image.asset(
                'assets/widgets/background/decor_atas.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/widgets/background/header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  children: [
                    Text(
                      'WORKOUT',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jersey25',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    Text(
                      'WORKOUT',
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
            Positioned.fill(
              top: 120,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Push Day Section
                    Stack(
                      children: [
                        Image.asset(
                          'assets/widgets/images/pushupman.png',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Push Day',
                                style: TextStyle(
                                  fontFamily: 'Jersey25',
                                  fontSize: 28,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Tombol START bisa di-adjust secara manual
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PushDayPage()),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/widgets/buttons/golden_button.png',
                                      height: 40,
                                      width: 120,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: Align(
                                        alignment: Alignment(0, -0.8),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 1),
                                          child: Text(
                                            'START',
                                            style: TextStyle(
                                              fontFamily: 'Jersey25',
                                              fontSize: 21,
                                              color: Colors.white,
                                              height: 1,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                  color: Colors.black45,
                                                ),
                                              ],
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
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Top for you',
                      style: TextStyle(
                        fontFamily: 'Jersey25',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          workoutCard('assets/widgets/images/corewomen.png',
                              'Core', const PlankPage(), context),
                          workoutCard('assets/widgets/images/legsman.png',
                              'Legs', const SquatsPage(), context),
                          workoutCard('assets/widgets/images/armman.png', 'Arm',
                              const ShoulderPressPage(), context),
                          workoutCard('assets/widgets/images/pullman.png',
                              'Pull', const BodyweightRowsPage(), context),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }
}

Widget workoutCard(
    String imagePath, String title, Widget targetPage, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(right: 16),
      width: 150,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Jersey25',
              fontSize: 28,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
