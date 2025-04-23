import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'completeyourprofile.dart';
import 'homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  bool _isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  // GOOGLE SIGN-IN
  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Google sign-in aborted');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('Google Sign-Up successful: ${user.email}');

        // Kirim data ke backend Django
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/register/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': user.email,
            'username': user.displayName,
            'google_uid': user.uid,
            'method': 'google_login',
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CompleteYourProfile()),
          );
        } else {
          final responseData = jsonDecode(response.body);
          if (responseData['error'] == 'Email is already in use') {
            // Kalau user udah pernah login dengan Google → langsung ke Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            print("Gagal menyimpan ke backend: ${response.body}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to register via Google")),
            );
          }
        }
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In Failed")),
      );
    }
  }

  // EMAIL + PASSWORD REGISTRATION
  Future<void> registerUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && _isValidEmail(email)) {
      try {
        // Daftar ke Firebase Authentication dulu
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final User? user = userCredential.user;

        if (user != null) {
          print(
              'Firebase email/password signup berhasil: ${user.email}, UID: ${user.uid}');

          // Kirim data ke backend Django
          const String apiUrl = 'http://10.0.2.2:8000/api/register/';
          final response = await http.post(
            Uri.parse(apiUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'username': email,
              'email': email,
              'password': password,
              'email_uid': user.uid,
              'method': 'email_login',
            }),
          );

          if (response.statusCode == 201 || response.statusCode == 200) {
            final data = jsonDecode(response.body);
            print("Berhasil daftar dan simpan ke Django: $data");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CompleteYourProfile(),
              ),
            );
          } else {
            final data = jsonDecode(response.body);
            print("Gagal simpan ke backend: $data");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['error'] ?? 'Registration failed')),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        print('Firebase Auth error: ${e.message}');
        String errorMsg = 'Registration failed';
        if (e.code == 'email-already-in-use') {
          errorMsg = 'Email is already in use';
        } else if (e.code == 'weak-password') {
          errorMsg = 'Password is too weak';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      } catch (e) {
        print('Error saat registrasi: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration error')),
        );
      }
    } else {
      _showErrorDialog('Please enter a valid email and password.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome !',
                style: TextStyle(
                  fontFamily: 'Jersey25',
                  fontSize: 42,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 4),
                      blurRadius: 15.0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter your details',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color(0xFF555555),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 239, 220),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 2),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 6,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Password', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 2),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 6,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Remember for 30 days',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 220, 220, 220),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Center(
                child: InkWell(
                  onTap: registerUser,
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
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: signUpWithGoogle,
                  child: Container(
                    height: 50,
                    width: 240,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/widgets/buttons/silver_button.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: const Offset(0, -8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/widgets/images/google_logo.png',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Sign Up with Google',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do you have an account? ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/widgets/images/dumbell_image.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
