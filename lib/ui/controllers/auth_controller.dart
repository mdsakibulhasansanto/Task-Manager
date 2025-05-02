import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_models.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;

  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  // Save User Data to SharedPreferences
  static Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }

  // Get User Data from SharedPreferences
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    final String? userData = sharedPreferences.getString(_userDataKey);

    if (userData != null) {
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  // Check if the user is logged in
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      await getUserData();
      return true; // User is logged in
    }

    return false; // User is not logged in
  }

  // Clear User Data from SharedPreferences
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userModel = null;
  }

  
}
