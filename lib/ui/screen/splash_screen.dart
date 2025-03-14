import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../widget/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, SignIn.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenBackground(child: Center(child: Text('SplashScreen'))));
  }
}
