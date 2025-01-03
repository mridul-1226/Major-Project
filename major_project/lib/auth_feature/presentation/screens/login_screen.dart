import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:major_project/student_dashboard.dart/presentation/screens/student_approval_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isStudentMode = true;
  bool _isOtpMode = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _registrationController.dispose();
    _otpController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleLoginMode() {
    setState(() {
      _isStudentMode = !_isStudentMode;
      if (_isStudentMode) {
        _animationController.forward(from: 0.0);
      } else {
        _animationController.reverse(from: 1.0);
      }
    });
  }

  void _submitRegistration() {
    setState(() {
      _isOtpMode = true;
      _animationController.forward(from: 0.0);
    });
  }

  void _goBackToRegistration() {
    setState(() {
      _isOtpMode = false;
      _animationController.reverse(from: 1.0);
    });
  }

  void _submitOtp() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const StudentApprovalScreen(),
        ),
        (_) => false);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('OTP Submitted')),
    // );
  }

  void _adminLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Admin Login Attempted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[200]!,
              Colors.deepPurple[800]!,
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final isFrontSide = _rotationAnimation.value <= math.pi / 2;
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_rotationAnimation.value),
                alignment: Alignment.center,
                child: isFrontSide
                    ? _buildCardContent()
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        child: _buildCardContent(isFlipped: true),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent({bool isFlipped = false}) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Student',
                  style: TextStyle(
                    color: _isStudentMode ? Colors.deepPurple : Colors.grey,
                    fontWeight:
                        _isStudentMode ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Switch(
                  value: !_isStudentMode,
                  onChanged: (_) => _toggleLoginMode(),
                  activeColor: Colors.deepPurple,
                  activeTrackColor: Colors.deepPurple.shade200,
                  inactiveTrackColor: Colors.deepPurple.shade100,
                  inactiveThumbColor: Colors.deepPurple.shade300,
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.deepPurple;
                  }),
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.deepPurpleAccent),
                ),
                Text(
                  'Admin',
                  style: TextStyle(
                    color: !_isStudentMode ? Colors.deepPurple : Colors.grey,
                    fontWeight:
                        !_isStudentMode ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              isFlipped
                  ? (!_isStudentMode ? 'Admin Login' : 'Verify OTP')
                  : (_isStudentMode
                      ? (_isOtpMode ? 'Verify OTP' : 'Student Login')
                      : 'Admin Login'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            _isStudentMode && !_isOtpMode
                ? TextField(
                    controller: _registrationController,
                    decoration: InputDecoration(
                      labelText: 'Registration/Roll No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon:
                          const Icon(Icons.school, color: Colors.deepPurple),
                    ),
                  )
                : _isStudentMode && _isOtpMode
                    ? Column(
                        children: [
                          TextField(
                            controller: _otpController,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.security,
                                  color: Colors.deepPurple),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.deepPurple),
                                onPressed: _goBackToRegistration,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'OTP sent to your registered email',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.person,
                                  color: Colors.deepPurple),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Colors.deepPurple),
                            ),
                          ),
                        ],
                      ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isStudentMode
                  ? (_isOtpMode ? _submitOtp : _submitRegistration)
                  : _adminLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _isStudentMode ? (_isOtpMode ? 'Submit' : 'Get OTP') : 'Submit',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
