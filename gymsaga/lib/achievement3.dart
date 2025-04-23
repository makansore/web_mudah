import 'package:flutter/material.dart';
import 'achievement.dart';
import 'achievement2.dart';

class Achievement3Screen extends StatelessWidget {
  const Achievement3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9D48B),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildAchievementGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/widgets/buttons/back_button.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Achievement',
                        style: TextStyle(
                          fontFamily: 'Jersey25',
                          fontSize: 40,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 4),
                              blurRadius: 30.0,
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A3D2B),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFFF9D48B),
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Achievement 0/10',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/widgets/images/gold_trophy.png',
                height: 110,
                width: 110,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCategoryTabs(context),
          const Divider(color: Colors.brown, thickness: 2),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryTab("Bronze", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AchievementScreen()),
          );
        }),
        _buildCategoryTab("Silver", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Achievement2Screen()),
          );
        }),
        _buildCategoryTab("Gold", true, () {}),
      ],
    );
  }

  Widget _buildCategoryTab(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 3,
              width: 50,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  Widget _buildAchievementGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        // Sample achievement data for Gold level
        List<Map<String, dynamic>> achievements = [
          {
            'title': 'Step Master',
            'description': 'Walked 50,000 steps in a\nsingle day.',
            'progress': 0,
          },
          {
            'title': 'Calories Crusher',
            'description': 'Burned 1000 calories in a\nsingle workout.',
            'progress': 0,
          },
          {
            'title': 'Workout Warrior',
            'description': 'Completed 15 workouts\nin a week.',
            'progress': 0,
          },
          {
            'title': 'Consistency\nChampion',
            'description': 'Logged workouts for 90\nconsecutive days.',
            'progress': 0,
          },
          {
            'title': 'Distance Dominator',
            'description': 'Walked/Ran a total of 50\nkilometers.',
            'progress': 0,
          },
          {
            'title': 'Personal Best\nBreaker',
            'description': 'Achieved 10 new personal\nbests.',
            'progress': 0,
          },
          {
            'title': 'Levels Dominator',
            'description': '',
            'progress': 0,
          },
          {
            'title': 'Achievement Name',
            'description': '',
            'progress': 0,
          },
        ];
        // Get the current achievement data
        Map<String, dynamic> achievement = achievements[index];
        return _buildAchievementCard(
          achievement['title'],
          achievement['description'],
          achievement['progress'],
        );
      },
    );
  }

  Widget _buildAchievementCard(
      String title, String description, int progressPercent) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9E7B6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDFC288), width: 1.5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate proportional sizes based on available space
          final double availableHeight = constraints.maxHeight;
          final double titleHeight = availableHeight * 0.15;
          final double medalHeight = availableHeight * 0.35;
          final double descHeight = availableHeight * 0.2;
          final double bottomSectionHeight = availableHeight * 0.3;
          return Column(
            children: [
              // Title section
              SizedBox(
                height: titleHeight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Jersey25',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
              // Medal section
              SizedBox(
                height: medalHeight,
                child: Center(
                  child: Image.asset(
                    'assets/widgets/images/gold_medal.png',
                    height: medalHeight * 0.9,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Description text section
              SizedBox(
                height: descHeight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
              // Bottom section with progress bar
              SizedBox(
                height: bottomSectionHeight,
                child: Column(
                  children: [
                    // Status labels above progress bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Incompleted text - left aligned
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5C5C5C),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Incompleted',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Percentage text - right aligned
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '$progressPercent%',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Progress bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5C5C5C),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 10,
                            width: (constraints.maxWidth - 24) *
                                progressPercent /
                                100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700), // Gold color
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Yellow/black tape decoration at bottom
                    const Spacer(),
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/widgets/images/yellow_tape.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
