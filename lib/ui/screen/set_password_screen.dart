import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widget/screen_background.dart';
import '../utils/app_colors.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});
  static String name = '/SetPassword';

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: screenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Set password',
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    'Minimum length password 8 character with letter and number combination',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),

                  // Password field
                  TextFormField(
                    controller: _passwordTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    //obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password type ';
                      }
                      if (value.length < 8) {
                        return 'Minimum password length  8 ';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Confirm Password field
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    //obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please type confirm password';
                      }
                      if (value != _passwordTEController.text) {
                        return "Don't match password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Sign In Button OR Loading Indicator
                  _signInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _onSignInPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.themeColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                  const SizedBox(height: 40),

                  // Don't have account? Sign up
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account? ",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, SignIn.name, (value) => false);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Sign in button press logic
  void _onSignInPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _signInProgress = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _signInProgress = false;
        });

        // এখানে তুমি তোমার নেভিগেশন বা অন্যান্য লজিক দিতে পারো
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password set successful!')),
        );
      });
    }
  }
}
