import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:account_management/ui/screen/home_bottom_nav_screen.dart';
import 'package:account_management/ui/utils/app_colors.dart';
import 'package:http/http.dart' as http show post;

import '../../data/api.dart';
import '../../widget/screen_background.dart';


class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static String name = '/AddNewTask';

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _dateTEController = TextEditingController();
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _dataAddInProgress = false;

  @override
  void dispose() {
    _dateTEController.dispose();
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
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
                    'Add new task',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),

                  // Date Field
                  TextFormField(
                    controller: _dateTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: 'Enter date',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Subject Field
                  TextFormField(
                    controller: _subjectTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'Enter task subject',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  TextFormField(
                    controller: _descriptionTEController,
                    cursorColor: AppColors.themeColor,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Adjust padding
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Add Task Button OR Loading Indicator
                  Visibility(
                    visible: !_dataAddInProgress,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addNewTask();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Add New Task',
                        style: TextStyle(color: Colors.white),
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

  //  Add new task function Json object format
  Future<void> _addNewTask() async {
    setState(() {
      _dataAddInProgress = true;
    });

    // JSON object
    Map<String, String> data = {
      'date': _dateTEController.text,
      'sub': _subjectTEController.text,
      'des': _descriptionTEController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(Api().taskAdd),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );


      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData.toString())),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"] ?? "Failed")),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    } finally {
      setState(() {
        _dataAddInProgress = false;
      });
    }
  }



}
