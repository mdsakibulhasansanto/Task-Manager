import 'package:account_management/ui/screen/cancel_task_screen.dart';
import 'package:account_management/ui/screen/completed_screen.dart';
import 'package:account_management/ui/screen/new_task_screen.dart';
import 'package:account_management/ui/screen/progress_screen.dart';
import 'package:account_management/ui/utils/app_colors.dart';
import 'package:account_management/widget/screen_background.dart';
import 'package:flutter/material.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = '/MainBottomNavScreen';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  List<Widget> screen = [
    NewTaskScreen(),
    ProgressScreen(),
    CompletedScreen(),
    CancelTaskScreen()
  ];
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBackground(child: screen[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.themeColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.add_task), label: 'New task'),
          NavigationDestination(icon: Icon(Icons.autorenew), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.task_alt), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
        ],
      ),
    );
  }
}
