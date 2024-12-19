import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Models/snackBarMessages.dart';
import 'package:myapp/widgits/authService.dart';
import 'package:myapp/widgits/customButton.dart';
import 'package:myapp/widgits/customTextField.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String? _email, _password;
  bool _isLoading = false;

  Future<void> _logInUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.logInUser(_email, _password);
      Navigator.pushNamed(context, 'ChatScreen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarMessage.show(context, 'User not found.');
      } else if (e.code == 'wrong-password') {
        SnackBarMessage.show(context, 'Incorrect password.');
      } else {
        SnackBarMessage.show(context, 'Login failed: ${e.message}');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        const SizedBox(height: 16),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter your email.';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(data)) {
                              return 'Please enter a valid email.';
                            }
                            return null;
                          },
                          onChanged: (value) => _email = value,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          isObscure: true,
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter your password.';
                            } else if (data.length < 6) {
                              return 'Password must be at least 6 characters.';
                            }
                            return null;
                          },
                          onChanged: (value) => _password = value,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: 'Sign In',
                          onPressed: _logInUser,
                          isLoading: _isLoading,
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Register',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, 'RegisterScreen');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
