import 'dart:io';
import 'package:tracking_app/widgets/save_pet_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracking_app/widgets/photo_gallery.dart';


class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  late FirebaseAuth _auth;
  User? user;
  String? userId;
  File? selectedImage;
  bool isImageSelected = false;
  String imageUrl = '';

  onImageSelected(File? image) async {
    setState(() {
      selectedImage = image;
      isImageSelected = image != null;
    });
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    userId = user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextFormField(
                controller: breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  const Text(
                    'Photo of pet',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 60,
                    child: PhotoAndGallery(
                      onImageSelected: onImageSelected,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  savePet(
                      context,
                      nameController,
                      typeController,
                      breedController,
                      ageController,
                      isImageSelected,
                      imageUrl);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PetListPage()));
                },
                child: const Text('Save Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
