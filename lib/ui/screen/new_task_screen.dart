import 'package:account_management/widget/screen_background.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  Map<String, String> item = {
    'date': '22',
    'subject': 'First todo',
    'description': 'description'
  };

  List<Map<String, String>> items = [
    {'date': '01-03-2025', 'subject': 'First todo', 'description': 'This is a description for the first task'},
    {'date': '02-03-2025', 'subject': 'Second todo', 'description': 'This is a description for the second task'},
    {'date': '03-03-2025', 'subject': 'Third todo', 'description': 'This is a description for the third task'},
    {'date': '04-03-2025', 'subject': 'Fourth todo', 'description': 'This is a description for the fourth task'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBackground(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
              child: Expanded(
                child: Container(
                  //height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              items[index]['date'] ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: Text(
                              items[index]['subject'] ?? '',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              items[index]['description'] ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               margin: EdgeInsets.all(10),
                               height: 30,
                               width: 70,
                               decoration: BoxDecoration(
                                   color: AppColors.themeColor,
                                   borderRadius: BorderRadius.circular(10)),
                               child: Center(
                                 child: Text(
                                   'New '
                                       'Todo',
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontSize: 12),
                                 ),
                               ),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 TextButton(onPressed: (){},
                                     child: Icon(Icons.edit)
                                 ),
                                 TextButton(onPressed: (){},
                                     child: Icon(Icons.delete)
                                 )
                               ],
                             )
                           ],
                         )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(

                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.dark_mode_rounded,
                            size: 14,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
