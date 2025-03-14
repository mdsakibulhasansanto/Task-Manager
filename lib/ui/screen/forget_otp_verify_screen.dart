import 'dart:async';

import 'package:account_management/ui/screen/set_password_screen.dart';
import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widget/screen_background.dart';
import '../utils/app_colors.dart';

class ForgetOtpVerify extends StatefulWidget {
  const ForgetOtpVerify({super.key});
  static String name = '/ForgetOtpVerify';

  @override
  State<ForgetOtpVerify> createState() => _ForgetOtpVerifyState();
}

class _ForgetOtpVerifyState extends State<ForgetOtpVerify> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  // Timer count
  int _start = 60;
  Timer? _timer;

  // Resend button enable or disable
  bool _isResendAvailable = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Timer start function
  void startTimer() {
    _start = 60;
    _isResendAvailable = false;

    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        setState(() {
          _isResendAvailable = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    _timer?.cancel();
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
                    'Pin verification',
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification pin will send to your phone number',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),

                  // === Pin verification Field ===
                  PinCodeTextField(
                    length: 6,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      activeBorderWidth: 0.5,
                      disabledBorderWidth: 0.5,
                      inactiveBorderWidth: 0,
                      selectedBorderWidth: 0,
                      borderWidth: 0.5,
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedColor: AppColors.themeColor,
                      inactiveColor: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _otpTEController,
                    appContext: context,
                  ),

                  const SizedBox(height: 20),

                  // === Timer Text and Resend Button ===
                  Center(
                    child: _isResendAvailable
                        ? TextButton(
                            onPressed: () {
                              //  Resend OTP API call
                              print("Resend OTP Clicked!");
                              startTimer();
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Text(
                            'Resend OTP in $_start seconds',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  // === Verify Button ===
                  ElevatedButton(
                    onPressed: () {
                      if (_otpTEController.text.length == 6) {
                        if (_start == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Time expired! Please resend OTP.'),
                            ),
                          );
                        } else {
                          verifyOtp();
                          Navigator.pushNamed(context, SetPassword.name);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(' Please fill up field !!.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // === Don't have account? Sign in ===
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

  // === OTP Verify Function ===
  void verifyOtp() {
    String otp = _otpTEController.text.trim();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 6 digit OTP')),
      );
      return;
    }

    print('Verifying OTP: $otp');
    // এখানে OTP Verify API কল করবে
  }
}
