// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracking_app/providers/user_provider.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? _userFromFirebase(auth.User? user) {
    print("User from Firebase: $user");
    if (user == null) {
      return null;
    }

    return User(user.uid, user.email!);
  }
  // "Default Name", 0

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = _userFromFirebase(credential.user);
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).setUser(user);
    print("User signed in: $user");
    return user;
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('users').doc(credential.user!.uid).set({
        'email': email,
      });

      User? user = _userFromFirebase(credential.user);
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      print("User created: $user");
      return user;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print("Sign-out successful");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
