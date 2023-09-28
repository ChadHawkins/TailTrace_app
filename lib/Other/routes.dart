import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignUp(),
  '/home': (context) => const HomePage(),
  '/profile': (context) => const ProfilePage(),
};
