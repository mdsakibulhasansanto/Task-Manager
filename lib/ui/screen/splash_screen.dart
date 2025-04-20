import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../widget/screen_background.dart';
import '../controllers/auth_controller.dart';
import 'home_bottom_nav_screen.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if (isUserLoggedIn == true) {
      Navigator.pushReplacementNamed(context, HomeBottomNavScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, SignIn.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenBackground(child: Center(child: Text('SplashScreen'))));
  }
}
