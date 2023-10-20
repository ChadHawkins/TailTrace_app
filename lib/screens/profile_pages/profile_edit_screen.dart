// ignore_for_file: unused_local_variable, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final String initialFirstName;
  final String initialSurname;
  final String initialPhoneNumber;

  const ProfileEditPage({
    Key? key,
    required this.initialFirstName,
    required this.initialSurname,
    required this.initialPhoneNumber,
  }) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _surnameController;
  late TextEditingController _phoneNumberController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _surnameController = TextEditingController(text: widget.initialSurname);
    _phoneNumberController =
        TextEditingController(text: widget.initialPhoneNumber.toString());
  }

  void _saveProfile() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      final firstName = _firstNameController.text;
      final surname = _surnameController.text;
      final phoneNumber = int.parse(_phoneNumberController.text);

      final updatedFirstName = _firstNameController.text;
      final updatedSurname = _surnameController.text;
      final updatedPhoneNumber = _phoneNumberController.text;
      User? user = FirebaseAuth.instance.currentUser;

      if (updatedFirstName != widget.initialFirstName ||
          updatedSurname != widget.initialSurname ||
          updatedPhoneNumber != widget.initialPhoneNumber) {
        FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
          'First Name': updatedFirstName,
          'Surname': updatedSurname,
          'Phone number': updatedPhoneNumber,
        });

        print('Updated First Name: $updatedFirstName');
        print('Updated Surname: $updatedSurname');
        print('Updated Phone Number: $updatedPhoneNumber');
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit my Profile'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLength: 20,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        controller: _firstNameController,
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        maxLength: 20,
                        decoration: const InputDecoration(labelText: 'Surname'),
                        controller: _surnameController,
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        maxLength: 10,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _saveProfile,
                        label: const Text('Save Profile'),
                        icon: const Icon(Icons.save),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
