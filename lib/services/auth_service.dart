// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tracking_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email!);
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('users').doc(credential.user!.uid).set({
        'email': email,
      });

      return _userFromFirebase(credential.user);
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
