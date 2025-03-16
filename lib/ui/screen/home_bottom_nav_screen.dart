import 'package:account_management/ui/utils/app_colors.dart';
import 'package:account_management/widget/screen_background.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_appBar.dart';
import '../../widget/home_floatingActionButton.dart';
import 'cancel_task_screen.dart';
import 'completed_screen.dart';
import 'new_task_screen.dart';
import 'progress_screen.dart';

class HomeBottomNavScreen extends StatefulWidget {
  const HomeBottomNavScreen({super.key});

  static String name = '/MainBottomNavScreen';

  @override
  State<HomeBottomNavScreen> createState() => _HomeBottomNavScreenState();
}

class _HomeBottomNavScreenState extends State<HomeBottomNavScreen> {
  final List<Widget> screen = [
    NewTaskScreen(),
    ProgressScreen(),
    CompletedScreen(),
    CancelTaskScreen(),
  ];

  int _selectedIndex = 0;


  void _onProfileImageTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile image change')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // app bar assignment for widget directory
      appBar: CustomAppBar(),
      // body assignment for widget directory
      body: screenBackground(child: screen[_selectedIndex]),
      //  FloatingAction button assignment for widget directory
      floatingActionButton: HomeFloatingActionButton(),

      // Custom NavigationBar Starts Here
      bottomNavigationBar:  Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: AppColors.themeColor.withOpacity(0),
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const TextStyle(
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                }
                return const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                );
              },
            ),
          ),
          child: NavigationBar(
            height: 80,
            backgroundColor: Colors.white,
            elevation: 0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                icon: _navIcon(Icons.add_task_outlined, 0),
                selectedIcon: _navSelectedIcon(Icons.add_task, 0),
                label: 'New Task',
              ),
              NavigationDestination(
                icon: _navIcon(Icons.autorenew_outlined, 1),
                selectedIcon: _navSelectedIcon(Icons.autorenew, 1),
                label: 'Progress',
              ),
              NavigationDestination(
                icon: _navIcon(Icons.task_alt_outlined, 2),
                selectedIcon: _navSelectedIcon(Icons.task_alt, 2),
                label: 'Completed',
              ),
              NavigationDestination(
                icon: _navIcon(Icons.cancel_outlined, 3),
                selectedIcon: _navSelectedIcon(Icons.cancel, 3),
                label: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Custom NavigationBar icon for unselected items
  Widget _navIcon(IconData icon, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(90),
      splashColor: AppColors.themeColor.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.grey[600],
          size: 28,
        ),
      ),
    );
  }

  // Custom icon for selected items
  Widget _navSelectedIcon(IconData icon, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(90),
      splashColor: AppColors.themeColor.withOpacity(0.4),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(90),
        ),
        child: Icon(
          icon,
          color: AppColors.themeColor,
          size: 30,
        ),
      ),
    );
  }



}
