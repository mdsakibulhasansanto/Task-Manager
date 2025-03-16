

import 'package:flutter/material.dart';

import '../ui/screen/add_new_task.dart';
import '../ui/utils/app_colors.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: false,
      onPressed: () {
        Navigator.pushNamed(context, AddNewTask.name);
      },
      backgroundColor: AppColors.themeColor, // Background color of FAB
      elevation: 2, // Icon inside FAB
      shape: RoundedRectangleBorder(
        // Shape with rounded corners
        borderRadius: BorderRadius.circular(90), // Set border radius
      ),
      tooltip: "Add New", // Shadow of FAB
      child:  Icon(Icons.add,color: Colors.white,), // Tooltip on long press
    );
  }
}

