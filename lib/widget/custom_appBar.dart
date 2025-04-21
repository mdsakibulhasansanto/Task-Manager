import 'dart:convert';
import 'package:account_management/ui/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/controllers/auth_controller.dart';
import '../ui/utils/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? token;
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('access-token');
      final userData = prefs.getString('user-data');
      debugPrint('User Data : $userData');
      if (userData != null) {
        final decoded = jsonDecode(userData);
        name = decoded['name'] ?? '';
        email = decoded['email'] ?? '';
      }
    });
  }





  void _onProfileImageTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile image change')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.isNotEmpty ? name : 'Loading',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 0),
          Text(
            email ?? '',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
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
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.photo_camera,
                    size: 10,
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
          onPressed: () {
            AuthController.clearUserData();
            Navigator.pushNamedAndRemoveUntil(context, SignIn.name, (route) => false);
          },
          icon: const Icon(Icons.settings_backup_restore, color: Colors.white),
        )
      ],
    );
  }
}
