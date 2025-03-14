import 'package:account_management/ui/screen/forget_otp_verify_screen.dart';
import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widget/screen_background.dart';
import '../utils/app_colors.dart';

class ForgetPhoneNumber extends StatefulWidget {
  const ForgetPhoneNumber({super.key});
  static String name = '/ForgetPhoneNumber';

  @override
  State<ForgetPhoneNumber> createState() => _ForgetPhoneNumberState();
}

class _ForgetPhoneNumberState extends State<ForgetPhoneNumber> {
  final TextEditingController _phoneTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  void dispose() {
    _phoneTEController.dispose();
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
                    'Your phone number',
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit  verification pin will send to your phone number',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),

                  // Phone Number Field
                  TextFormField(
                    controller: _phoneTEController,
                    cursorColor: AppColors.themeColor,
                    cursorErrorColor: AppColors.themeColor,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 30),

                  // Sign In Button OR Loading Indicator
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetOtpVerify.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Send Otp',
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

        //Navigator.pushReplacementNamed( context , '/home');
      });
    }
  }
}
