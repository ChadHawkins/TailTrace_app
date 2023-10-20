// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tracking_app/widgets/forms/form_validators.dart';
import 'package:tracking_app/widgets/authScreen_widgets/my_button.dart';
import 'package:tracking_app/widgets/authScreen_widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracking_app/widgets/camera_and_gallery/img_picker_profile.dart';

final _firebase = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailContoller = TextEditingController();
  final _passwordController = TextEditingController();
  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  var _isauthenticating = false; //is image uploading variable
  var _isLogin = true;
  var _enteredPassword = '';
  var _enteredEmail = '';
  var _enteredName = '';
  var _enteredSurname = '';
  var _enteredPhoneNumber = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _formKey.currentState!.save();
    try {
      setState(() {
        _isauthenticating = true;
      });

      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Profile_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final profileImageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set(
          {
            'First Name': _enteredName,
            'Surname': _enteredSurname,
            'Phone number': _enteredPhoneNumber,
            'email': _enteredEmail,
            'password': _enteredPassword,
            'image_Url': profileImageUrl,
          },
        );
        setState(() {
          _isauthenticating = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authenrication Failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _isLogin ? 'login' : 'Sign up',
                      style: const TextStyle(
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
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (_isLogin)
                                    const Text(
                                      "Welcome to TailTrace, your trusted companion for pet tracking!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  if (!_isLogin)
                                    ProfilePhotoInput(
                                      onPickImage: (pickedImage) {
                                        _selectedImage = pickedImage;
                                      },
                                    ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  if (!_isLogin)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyTextField(
                                            hintText: 'Firstname',
                                            validator: validateName,
                                            onSaved: (value) {
                                              _enteredName = value!;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: MyTextField(
                                            hintText: 'Surname',
                                            validator: validateName,
                                            onSaved: (value) {
                                              _enteredSurname = value!;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  if (!_isLogin)
                                    MyTextField(
                                      hintText: 'PhoneNumber',
                                      validator: validateName,
                                      onSaved: (value) {
                                        _enteredPhoneNumber = value!;
                                      },
                                    ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  MyEmailTextField(
                                    controller: _emailContoller,
                                    hintText: 'user@gmail.com',
                                    validator: validateEmail,
                                    onSaved: (value) {
                                      _enteredEmail = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  MyPasswordTextField(
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    validator: validatePassword,
                                    obscureText: true,
                                    onSaved: (value) {
                                      _enteredPassword = value!;
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  if (!_isauthenticating)
                                    MyButtonAgree(
                                        text: _isLogin
                                            ? "Login"
                                            : "Agree and SignUp",
                                        onPressed: _submit),
                                  if (!_isauthenticating)
                                    if (!_isLogin)
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  if (_isauthenticating)
                                    Transform.scale(
                                      scale: 1,
                                      child: const LinearProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 71, 233, 133),
                                        ),
                                        minHeight: 10,
                                      ),
                                    ),
                                  const SizedBox(height: 10),
                                  if (!_isauthenticating)
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: Text(
                                        _isLogin
                                            ? 'Create an account'
                                            : 'I already have an account.',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 233, 133),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
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
