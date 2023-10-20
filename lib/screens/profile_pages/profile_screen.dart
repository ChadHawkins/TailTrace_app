// ignore_for_file: unused_element, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/models/user_profile.dart';
import 'package:tracking_app/screens/profile_pages/profile_edit_screen.dart';
import 'package:tracking_app/widgets/profile/profile_fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? _userProfile;
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final userProfile = UserProfile(
        firstName: userData['First Name'] ?? '',
        surname: userData['Surname'] ?? '',
        phoneNumber: userData['Phone number'] ?? '',
        email: userData['email'] ?? '',
        imageUrl: userData['image_Url'] ?? '',
      );

      setState(() {
        _userProfile = userProfile;
      });
    }
  }

  void _editProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final initialFirstName = userData['First Name'] ?? '';
        final initialSurname = userData['Surname'] ?? '';
        final initialPhoneNumber = userData['Phone number'] ?? '';

        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (ctx) => ProfileEditPage(
              initialFirstName: initialFirstName,
              initialSurname: initialSurname,
              initialPhoneNumber: initialPhoneNumber,
            ),
          ),
        )
            .then((_) {
          _loadProfile();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: _editProfile,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: _userProfile != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_userProfile!.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileField(
                      label: 'First Name', value: _userProfile!.firstName),
                  ProfileField(label: 'Surname', value: _userProfile!.surname),
                  ProfileField(
                      label: 'Phone Number', value: _userProfile!.phoneNumber),
                  ProfileField(label: 'Email', value: _userProfile!.email),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
