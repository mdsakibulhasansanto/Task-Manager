import 'package:account_management/data/api.dart';
import 'package:account_management/data/services/network_caller.dart';
import 'package:account_management/widget/screen_background.dart';
import 'package:account_management/widget/snackBar.dart';
import 'package:flutter/material.dart';

import '../../data/models/newTaskDataGetModel.dart';
import '../utils/app_colors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<NewTaskDataGetModel> taskList = [];
  bool _getNewTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    dataGetMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBackground(
        child: _getNewTaskInProgress
            ? Center(child: CircularProgressIndicator(
          color: AppColors.themeColor,
        ))
            : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              task.date ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              task.des ?? 'Nothing',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              task.sub ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'New Todo',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> dataGetMethod() async {
    _getNewTaskInProgress = true;
    setState(() {});

    NetworkResponse response =
    await NetworkCaller.getRequest(url: Api().taskDataGet);

    if (response.isSuccess) {
      final taskData = response.responseData;

      if (taskData is Map<String, dynamic> && taskData['data'] is List) {
        taskList = (taskData['data'] as List).map((e) {
          return NewTaskDataGetModel.fromJson(e);
        }).toList();
      } else {
        showSnackBar(context, 'Unexpected data format');
      }
    } else {
      // Internet exception handle
      if (response.errorMessage.contains('SocketException')) {
        showSnackBar(context, 'No Internet Connection');
      } else {
        showSnackBar(context, response.errorMessage);
      }
    }

    _getNewTaskInProgress = false;
    setState(() {});
  }

}
