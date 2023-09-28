import 'dart:ui';
import 'package:tracking_app/screens/login_screen.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/screens/home_screen.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/utils/form_validators.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();

  final emailContoller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/wallpaper.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(_opacity),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                const Text(
                                  "Welcome to TailTrace, your trusted companion for pet tracking!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                MyTextField(
                                  controller: emailContoller,
                                  hintText: 'email',
                                  obscureText: false,
                                  validator: validateEmail,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                MyTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  validator: validatePassword,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                MyButtonAgree(
                                  text: "Agree and Continue",
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await authService
                                          .createUserWithEmailAndPassword(
                                        emailContoller.text,
                                        passwordController.text,
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    }
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                'By selecting Agree & Continue above, you agree to our ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          TextSpan(
                                              text:
                                                  'Terms of Service and Privacy Policy',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'ALready have an account?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(width: 4),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigate to the sign-up page when "Sign Up" is pressed
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage(), // Replace 'SignUpPage()' with your actual sign-up page widget.
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
