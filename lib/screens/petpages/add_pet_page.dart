// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/widgets/camera_and_gallery/img_picker_pet.dart';
import 'package:tracking_app/widgets/forms/form_validators.dart';
import 'package:tracking_app/models/pet.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() {
    return _AddPetPageState();
  }
}

class _AddPetPageState extends State<AddPetPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final pet = [];
  var _selectedTypeOfPet = TypeOfPet.Dog;
  File? _selectedImage;
  bool isImageSelected = false;
  String imageUrl = '';
  var _addingPet = false;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  onImageSelected(File? image) async {
    _selectedImage = image;
    isImageSelected = image != null;
  }

  var _enteredPetName = '';
  var _enteredPetAge = '';

  void _submit() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    final isvalid = _formkey.currentState!.validate();

    if (!isvalid) {
      return;
    }
    _formkey.currentState!.save();

    if (isvalid) {
      setState(() {
        _addingPet = true;
      });

      final String userId = user!.uid;
      final CollectionReference userPetsCollection =
          _firestore.collection('users').doc(userId).collection('pets');

      if (_selectedImage == null) {
        return;
      }

      final String fileName =
          '$_enteredPetName-${DateTime.now().millisecond}.jpg';
      final storageRef =
          FirebaseStorage.instance.ref().child('Pet_images').child(fileName);

      await storageRef.putFile(_selectedImage!);
      final petImageUrl = await storageRef.getDownloadURL();

      await userPetsCollection.add({
        'name': _enteredPetName,
        'age': _enteredPetAge,
        'type': _selectedTypeOfPet.toString(),
        'imageUrl': petImageUrl,
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_addingPet)
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: validatePetName,
                  onSaved: (value) {
                    _enteredPetName = value!;
                  },
                ),
              if (!_addingPet)
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: validatePetage,
                  onSaved: (value) {
                    _enteredPetAge = value!;
                  },
                ),
              const SizedBox(
                height: 16,
              ),
              if (!_addingPet)
                PhotoAndGallery(onImageSelected: onImageSelected),
              Row(
                children: [
                  if (!_addingPet)
                    DropdownButton(
                      value: _selectedTypeOfPet,
                      items: TypeOfPet.values
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedTypeOfPet = value;
                        });
                      },
                    ),
                  const Spacer(),
                  if (!_addingPet)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  if (!_addingPet)
                    ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.save),
                      label: const Text('Save Pet'),
                    ),
                ],
              ),
              if (_addingPet)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
