import 'package:account_management/widget/screen_background.dart';
import 'package:flutter/material.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBackground(
          child: Center(
        child: Text('Cancel task'),
      )),
    );
  }
}
