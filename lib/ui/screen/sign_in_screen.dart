import 'package:account_management/data/models/user_models.dart';
import 'package:account_management/ui/screen/forget_phoneNumber_verify.dart';
import 'package:account_management/ui/screen/home_bottom_nav_screen.dart';
import 'package:account_management/ui/screen/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api.dart';
import '../../data/services/network_caller.dart';
import '../../widget/screen_background.dart';
import '../../widget/snackBar.dart';
import '../controllers/auth_controller.dart';
import '../utils/app_colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String name = '/sign-in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  void dispose() {
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: screenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Get started with',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),

                  // Phone Number Field
                  TextFormField(
                    controller: _phoneTEController,
                    cursorColor: AppColors.themeColor,
                    cursorErrorColor: AppColors.themeColor,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Your phone number',
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

                  // Password Field
                  TextFormField(
                    controller: _passwordTEController,
                    cursorColor: AppColors.themeColor,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Your password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Sign In Button OR Loading Indicator
                  Visibility(
                    visible: !_signInProgress,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _signIn();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Forgot password button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPhoneNumber.name);
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),

                  // Don't have account? Sign up
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, SignUp.name);
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

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "number": _phoneTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Api().signIn,
      body: requestBody,
    );

    debugPrint('Response Body: ${response.responseData}');

    _signInProgress = false;
    setState(() {});

    if (response.isSuccess && response.responseData?['status'] == 'success') {
      try {
        final userJson = response.responseData?['user'];
        if (userJson is Map<String, dynamic>) {
          String token = response.responseData!['token'];
          UserModel userModel = UserModel.fromJson(userJson);
          await AuthController.saveUserData(token, userModel);
          Navigator.pushReplacementNamed(context, HomeBottomNavScreen.name);
        } else {
          showSnackBar(context, 'Invalid user data from server.');
        }
      } catch (e) {
        showSnackBar(context, 'Error parsing user data: $e');
      }
    }
    else {
      if (response.statusCode == 401) {
        showSnackBar(context, 'Email/Password is invalid! Try again.');
      } else {
        String message = response.responseData?['message'] ?? response.errorMessage;
        showSnackBar(context, message);
      }
    }
  }


}
