import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'passwordreset.dart';

class CheckEmailForCodePage extends StatefulWidget {
  final String email;
  const CheckEmailForCodePage({super.key, required this.email});
  @override
  CheckEmailForCodeState createState() => CheckEmailForCodeState();
}

class CheckEmailForCodeState extends State<CheckEmailForCodePage> {
  final List<TextEditingController> _codeControllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  bool _isCodeComplete = false;
  List<bool> _isFieldFilled = List.generate(5, (_) => false);
  int _resendCount = 0;
  bool _isResendEnabled = true;

  @override
  void initState() {
    super.initState();
    for (var controller in _codeControllers) {
      controller.addListener(_checkCodeCompletion);
    }
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _checkCodeCompletion() {
    setState(() {
      _isFieldFilled = _codeControllers
          .map((controller) => controller.text.isNotEmpty)
          .toList();
      _isCodeComplete =
          _codeControllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  void _handleVerification() {
    String enteredCode =
        _codeControllers.map((controller) => controller.text).join();
    // Navigasi ke halaman PasswordResetPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordResetPage(),
      ),
    );
  }

  void _resendEmail() {
    if (_isResendEnabled) {
      setState(() {
        _resendCount++;
        _isResendEnabled = false;
      });

      // Show a popup dialog instead of a snackbar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              'Email Sent',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Code successfully resent to your email: ${widget.email}',
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEC9F59),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          );
        },
      );

      // Enable resend after 30 seconds
      Future.delayed(const Duration(seconds: 30), () {
        setState(() {
          _isResendEnabled = true;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait before requesting another email'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9DEAF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Check your email',
                        style: TextStyle(
                          fontFamily: 'Jersey25',
                          fontSize: 30,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'We sent a reset link to ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            TextSpan(
                              text: widget.email,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\nEnter 5 digit code that mentioned in the email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Container(
                            width: 55,
                            height: 55,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFEC9F59),
                                width: 2,
                              ),
                              color: _isFieldFilled[index]
                                  ? Colors.white
                                  : const Color(0xFFFFF6DC),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFFFBD59),
                                  offset: Offset(2, 4),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _codeControllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: const TextStyle(fontSize: 24),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '•',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24,
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 4) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index + 1]);
                                }
                                _checkCodeCompletion();
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 50),
                      // Verify Button
                      Center(
                        child: InkWell(
                          onTap: _isCodeComplete ? _handleVerification : null,
                          child: Opacity(
                            opacity: _isCodeComplete ? 1.0 : 0.5,
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
                                child: const Text(
                                  'VERIFY CODE',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Haven\'t got the email yet?',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: _resendEmail,
                            child: Text(
                              'Resend Email',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isResendEnabled
                                    ? Colors.blue
                                    : Colors.grey,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
