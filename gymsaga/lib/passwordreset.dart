import 'package:flutter/material.dart';
import 'setnewpassword.dart'; // Import the SetNewPasswordPage

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.chevron_left, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Text(
                'Verify is Success',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey25',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Your Verify Email has been successfully Land. Click confirm to set a new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Jersey25',
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to SetNewPasswordPage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetNewPasswordPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 340,
                    height: 70,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/widgets/buttons/golden_button.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: const Offset(0, -13), // Geser dikit ke atas
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontFamily: 'Jersey25',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
