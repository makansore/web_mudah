// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatCaloriesPage extends StatelessWidget {
  const StatCaloriesPage({super.key});
  
  // Define navigation routes for the other statistic pages
  static const String weightRoute = '/stat_weight';
  static const String stepsRoute = '/stat_steps';
  static const String workoutsRoute = '/stat_workouts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          // Use checkerboard pattern background
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/widgets/background/checkerboard.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Column(
            children: [
              // Header with orange background
              Container(
                color: const Color.fromARGB(255, 228, 205, 167), // Light orange/beige background color
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  children: [
                    // Back button and title
                    Row(
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/widgets/buttons/back_button.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ),
                        
                        Expanded(
                          child: Center(
                            child: Text(
                              'STATISTICS',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 32, 32, 32), // Dark text color
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        
                        // Empty SizedBox for balance
                        SizedBox(width: 30.0),
                      ],
                    ),
                    
                    // Tab Bar - Custom implementation with image backgrounds
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      height: 40.0,
                      child: Row(
                        children: [
                          // CALORIES tab - selected by default
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Already on this page
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/widgets/background/stat_navbar.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'CALORIES',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // WEIGHT tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/stat_weight.dart');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/widgets/background/stat_navbar.png'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      Colors.grey.withOpacity(0.7), 
                                      BlendMode.modulate,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'WEIGHT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // STEPS tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/stat_steps');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/widgets/background/stat_navbar.png'),
                                    fit: BoxFit.fill,
                                    // S,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'STEPS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // WORKOUTS tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/stat_workouts');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/widgets/background/stat_navbar.png'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      Colors.grey.withOpacity(0.7), 
                                      BlendMode.modulate,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'WORKOUTS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ),
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    child: Image.asset(
                      'assets/widgets/background/garis.png',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.none, // atau BoxFit.cover, tergantung efek yang kamu mau
                    ),
                  ),
                    
                  ],
                ),
              ),
              
              // Content - Since we removed TabBarView, only showing calories content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      sectionTitle('Calories Burned'),
                      sectionSubtitle('7-Days'),
                      caloriesBarChart(days: true),
                      sectionSubtitle('Months'),
                      caloriesBarChart(),
                      sectionSubtitle('Years'),
                      yearBarChart(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Jersey25',
            fontSize: 18,
            color: Colors.brown[800],
          ),
        ),
      ),
    );
  }

  Widget sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Jersey25',
          fontSize: 12,
          color: Colors.brown[600],
        ),
      ),
    );
  }

  Widget caloriesBarChart({bool days = false}) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: List.generate(7, (i) {
            final values = [600, 700, 850, 670, 620, 590, 710];
            return BarChartGroupData(x: i, barRods: [
              BarChartRodData(toY: values[i] / 1000, width: 18, color: Colors.deepOrangeAccent),
            ]);
          }),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: const Color.fromARGB(255, 188, 170, 164),
              dashArray: [5],
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30, interval: 0.2)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final labels = days
                      ? ['28', '29', '30', '31', '1', '2', '3']
                      : ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      labels[value.toInt() % labels.length],
                      style: TextStyle(fontFamily: 'Jersey25', fontSize: 8),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget yearBarChart() {
    final years = ['2023', '2024', '2025'];
    final values = [320, 370, 280];
    return AspectRatio(
      aspectRatio: 1.4,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          barGroups: List.generate(3, (i) => BarChartGroupData(x: i, barRods: [
            BarChartRodData(toY: values[i] / 100, width: 22, color: Colors.deepOrange),
          ])),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: const Color.fromARGB(255, 188, 170, 164),
              dashArray: [5],
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    years[value.toInt()],
                    style: TextStyle(fontFamily: 'Jersey25', fontSize: 8),
                  ),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}