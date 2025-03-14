import 'package:account_management/ui/screen/forget_otp_verify_screen.dart';
import 'package:account_management/ui/screen/forget_phoneNumber_verify.dart';
import 'package:account_management/ui/screen/main_bottom_nav_screen.dart';
import 'package:account_management/ui/screen/set_password_screen.dart';
import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:account_management/ui/screen/sign_up_screen.dart';
import 'package:account_management/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  StatusBar Color set
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black54),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          ),
        ),
        textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            titleSmall: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            )),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          focusColor: AppColors.themeColor,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      routes: {
        '/': (context) => SplashScreen(),
        SignIn.name: (context) => SignIn(),
        SignUp.name: (context) => SignUp(),
        ForgetPhoneNumber.name: (context) => ForgetPhoneNumber(),
        ForgetOtpVerify.name: (context) => ForgetOtpVerify(),
        SetPassword.name: (context) => SetPassword(),
        MainBottomNavScreen.name: (context) => MainBottomNavScreen(),
      },
    );
  }
}
