import 'dart:convert';

import 'package:account_management/api/api.dart';
import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http show post;

import '../../widget/screen_background.dart';
import '../utils/app_colors.dart';
import 'home_bottom_nav_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String name = '/sign-up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  void dispose() {
    _phoneTEController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
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
                  const SizedBox(height: 50),
                  Text(
                    'Join with us',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Phone Number
                  TextFormField(
                    controller: _phoneTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Icon(
                          Icons.phone_android_rounded,
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

                  // First Name
                  TextFormField(
                    controller: _firstNameController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'First name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  TextFormField(
                    controller: _lastNameController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Last name',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Your email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        )),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid email';
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password
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
                        return 'Enter a password';
                      } else if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  Visibility(
                    visible: !_signInProgress,
                    replacement: const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _onSignUpPressed;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Already have account? Sign In
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, SignIn.name);
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

  // Sign up button press logic
  Future<void> _onSignUpPressed() async {
    setState(() {
      _signInProgress = true;
    });

    // JSON object
    Map<String, String> data = {
      'name' : _firstNameController.text + _lastNameController.text,
      'number' : _phoneTEController.text,
      'email' : _emailController.text,
      'password' : _passwordTEController.text,
      'key' : '12345678'

    };

    try {
      final response = await http.post(
        Uri.parse(Api().signUp),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );


      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Map<String, String> resData = {
          'status': responseData['status'].toString(),
          'message': responseData['message'].toString()
        };
        ScaffoldMessenger.of( context ).showSnackBar(
          SnackBar(
            content: Text(  "${resData['status']!} : ${resData['message']!}"),
          ),
        );

        // 2 second delayed
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, HomeBottomNavScreen.name);
        });

      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"] ?? "Failed")),
        );
      }

    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            "Server not found $e",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      );
    } finally {
      setState(() {
        _signInProgress = false;
      });
    }
  }


}
