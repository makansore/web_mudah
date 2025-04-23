import 'package:flutter/material.dart';
import 'navbar.dart';
import 'steps.dart';
import 'profile.dart';
import 'workout.dart';
import 'finishsettingup.dart';
import 'create_workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3), // Background color
      body: SafeArea(
        child: Stack(
          children: [
            // Checkerboard pattern background
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/widgets/background/checkerboard.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            
            // Decor overlay right under header (dipindahkan ke belakang header)
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

            // Centered "WELCOME BACK, KATIE" Text
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  children: [
                    // Text outline
                    Text(
                      'WELCOME BACK, KATIE',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jersey25',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    // Text fill with shadow
                    Text(
                      'WELCOME BACK, KATIE',
                      style: TextStyle(
                        fontSize: 24,
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

            // Actual page content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100), // mempertahankan spasi konten utama seperti kode awal
                  
                  // Daily Quest section with frame
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/widgets/background/quest_frame.png',
                          width: double.infinity,
                        ),
                        const Positioned(
                          top: 25,
                          child: Text(
                            'Daily Quest:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9C27B0),
                              fontFamily: 'Jersey25',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Weekly calendar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDayBox('Sun', '2', false),
                        _buildDayBox('Mon', '3', false),
                        _buildDayBox('Tue', '4', false),
                        _buildDayBox('Wed', '5', true),
                        _buildDayBox('Thu', '6', false),
                        _buildDayBox('Fri', '7', false),
                        _buildDayBox('Sat', '8', false),
                      ],
                    ),
                  ),
                  
                  // Reminder box
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/widgets/background/frame.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/widgets/icons/weight.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Don't forget to do your daily weigh in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jersey25',
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.close, color: Colors.black),
                      ],
                    ),
                  ),
                  
                  // Today's workouts header
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Today's Scheduled Workouts",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jersey25',
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Workout cards
                  _buildWorkoutCard(
                    context: context,
                    title: "Push Day",
                    xp: "+120 XP",
                    exercises: "Pushups | Pike Pushups | Dips",
                  ),
                  _buildWorkoutCard(
                    context: context,
                    title: "Legs",
                    xp: "+100 XP",
                    exercises: "Squats | Lunges | Glute Bridges | Calf Rises",
                  ),
                  
                  const SizedBox(height: 80), // Extra space for navbar
                ],
              ),
            ),
            
            // Button create_workout di posisi fix kanan bawah (di atas navbar)
            Positioned(
              right: 20,
              bottom: 20, // posisi di atas navbar
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
                  );
                },
                child: Image.asset(
                  'assets/widgets/buttons/create_workout.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 0),
    );
  }

  Widget _buildDayBox(String day, String number, bool isSelected) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/widgets/icons/date.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.toUpperCase(), 
            style: const TextStyle(
              fontSize: 10, 
              fontWeight: FontWeight.bold,
              fontFamily: 'Jersey25',
              color: Colors.black,
            )
          ),
          Text(
            number, 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              fontFamily: 'Jersey25',
              color: isSelected ? const Color(0xFFE32020) : Colors.black,
              shadows: isSelected ? [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ] : [],
            )
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard({
    required BuildContext context,
    required String title,
    required String xp,
    required String exercises,
    bool showAddButton = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/widgets/background/frame.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jersey25',
                            ),
                          ),
                          // XP text with white outline
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // White outline for XP text
                              Text(
                                xp,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Jersey25',
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.white,
                                ),
                              ),
                              // Blue fill for XP text
                              Text(
                                xp,
                                style: const TextStyle(
                                  color: Color(0xFF00BFFF),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jersey25',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        exercises,
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.grey[700],
                          fontFamily: 'Jersey25',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showAddButton)
            Positioned(
              right: 15,
              bottom: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
                  );
                },
                child: Image.asset(
                  'assets/widgets/buttons/create_workout.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}