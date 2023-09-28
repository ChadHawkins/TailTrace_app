import 'package:flutter/material.dart';
import 'package:tracking_app/screens/home_screen.dart';
import 'package:tracking_app/screens/login_screen.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return const HomePage();
          } else {
            return LoginPage();
          }
        }
        return const Scaffold(body: CircularProgressIndicator());
      },
    );
  }
}
