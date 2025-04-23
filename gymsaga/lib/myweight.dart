import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWeightPage extends StatefulWidget {
  const MyWeightPage({super.key});

  @override
  State<MyWeightPage> createState() => _MyWeightPageState();
}

class _MyWeightPageState extends State<MyWeightPage> {
  double currentWeight = 60.4;
  DateTime selectedDate = DateTime.now();
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _weightController =
        TextEditingController(text: currentWeight.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _incrementWeight() {
    setState(() {
      if (currentWeight < 999.9) {
        currentWeight += 0.1;
        currentWeight = double.parse(currentWeight.toStringAsFixed(1));
        _weightController.text = currentWeight.toStringAsFixed(1);
        _weightController.selection = TextSelection.fromPosition(
          TextPosition(offset: _weightController.text.length),
        );
      }
    });
  }

  void _decrementWeight() {
    setState(() {
      currentWeight -= 0.1;
      if (currentWeight < 0) currentWeight = 0;
      currentWeight = double.parse(currentWeight.toStringAsFixed(1));
      _weightController.text = currentWeight.toStringAsFixed(1);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              // Header with shadow separator
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7E4C3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Back button centered vertically
                    Positioned(
                      left: 16,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/widgets/buttons/back_button.png',
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ),
                    ),

                    // MY WEIGHT text centered horizontally and vertically
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Stack(
                          children: [
                            // Text outline
                            Text(
                              'MY WEIGHT',
                              style: TextStyle(
                                fontSize: 32,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 3
                                  ..color = Colors.black,
                              ),
                            ),
                            // Text fill with shadow
                            Text(
                              'MY WEIGHT',
                              style: TextStyle(
                                fontSize: 32,
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
                  ],
                ),
              ),

              SizedBox(height: 40),

              // "For Today or" text with calendar icon centered horizontally
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'For Today or',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Image.asset(
                        'assets/widgets/buttons/button_calendar.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60),

              // "Weigh In" label
              Center(
                child: Text(
                  'Weigh In',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              SizedBox(height: 8),

// Weight selector row with editable TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Minus Button
                  GestureDetector(
                    onTap: _decrementWeight,
                    child: Image.asset(
                      'assets/widgets/buttons/button_min.png',
                      width: 66,
                      height: 66,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                    ),
                  ),

                  // Editable Weight Display
                  Container(
                    width: 160,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _weightController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              textAlign: TextAlign.right,
                              onChanged: (value) {
                                final parsed = double.tryParse(value);
                                if (parsed != null) {
                                  setState(() {
                                    currentWeight = parsed;
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  final newText = newValue.text;

                                  // Allow empty input
                                  if (newText.isEmpty) return newValue;

                                  // Parse to double
                                  final parsed = double.tryParse(newText);
                                  if (parsed == null) return oldValue;

                                  // Check if integer part is more than 3 digits
                                  final parts = newText.split('.');
                                  if (parts[0].length > 3) return oldValue;

                                  // Optional: limit decimal places to 1
                                  if (parts.length == 2 &&
                                      parts[1].length > 1) {
                                    return oldValue;
                                  }

                                  return newValue;
                                }),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Kg',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Plus Button
                  GestureDetector(
                    onTap: _incrementWeight,
                    child: Image.asset(
                      'assets/widgets/buttons/button_plus.png',
                      width: 66,
                      height: 66,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Done Button - centered alignment
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Button background image
                    Image.asset(
                      'assets/widgets/buttons/golden_button_large.png',
                      width: 300,
                      height: 80,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                    ),
                    Positioned(
                      top: 6, // Moves the text up
                      child: Text(
                        'DONE',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
