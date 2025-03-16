
import 'package:flutter/material.dart';

import '../ui/utils/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});




  void _onProfileImageTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile image change')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Md Sakibul hasan santo',style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold

            ),),
            SizedBox(height: 0,),
            Text('mdsakibulhasansanto@gmail.com',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.normal
              ),),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () => _onProfileImageTap(context),
            child: Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/santo.jpg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(

                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.photo_camera,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.settings_backup_restore,color: Colors.white,)
          
          )
        ],

      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
