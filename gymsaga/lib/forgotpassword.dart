import 'package:flutter/material.dart';
import 'checkemailforcode.dart'; // Import the CheckEmailForCodePage

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailFilled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkEmailFilled);
  }

  void _checkEmailFilled() {
    setState(() {
      _isEmailFilled = _emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title and subtitle aligned to the left
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                      fontFamily: 'Jersey25',
                      fontSize: 38,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset:
                              Offset(1.5, 1.5), // lebih kecil dari sebelumnya
                          blurRadius: 1.5, // tambahin blur dikit
                          color:
                              Colors.black.withOpacity(0.4), // transparan dikit
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please enter your email to reset the password',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Form container
                Container(
                  width: 400,
                  // HAPUS background putih & boxShadow
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Email',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor:
                              const Color(0xFFFFFBE6), // warna dalam input
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9CFE3),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9CFE3),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Reset Password Button
                Center(
                  child: InkWell(
                    onTap: _isEmailFilled
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckEmailForCodePage(
                                  email: _emailController.text,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Opacity(
                      opacity: _isEmailFilled ? 1.0 : 0.5,
                      child: Container(
                        height: 74,
                        width: 332,
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
                            'RESET PASSWORD',
                            style: TextStyle(
                              fontFamily: 'Jersey25',
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}