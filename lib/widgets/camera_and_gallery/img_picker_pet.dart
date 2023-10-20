// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PhotoAndGallery extends StatefulWidget {
  const PhotoAndGallery({
    super.key,
    required this.onImageSelected,
  });

  final void Function(File? image) onImageSelected;

  @override
  State<PhotoAndGallery> createState() => _PhotoAndGalleryState();
}

class _PhotoAndGalleryState extends State<PhotoAndGallery> {
  File? image;
  bool isImageSelected = false;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          isImageSelected = true;
          uploadPetFile();
        });
      } else {
        print('No image selected from gallery');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          isImageSelected = true;
          uploadPetFile();
        });
      } else {
        print('No image taken');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPetFile() async {
    if (image == null) return '';

    final fileName = basename(image!.path);
    final destination = 'Pets/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(fileName);
      await ref.putFile(image!);

      widget.onImageSelected(image);
    } catch (e) {
      print('error occured: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: getImageFromCamera,
          child: const Text("Camera",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            await getImageFromGallery();
          },
          child: const Text("Gallery",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        GestureDetector(
          onTap: getImageFromCamera,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: const AssetImage('assets/images/addpet.jpg'),
            foregroundImage: image != null ? FileImage(image!) : null,
          ),
        ),
      ],
    );
  }
}
