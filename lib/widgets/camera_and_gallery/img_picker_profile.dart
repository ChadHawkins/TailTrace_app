// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoInput extends StatefulWidget {
  const ProfilePhotoInput({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<ProfilePhotoInput> createState() {
    return _ProfilePhotoInputState();
  }
}

class _ProfilePhotoInputState extends State<ProfilePhotoInput> {
  File? _profileImage;

  void _takePhoto() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 250);

    if (pickedImage == null) {
      return;
    }

    setState(
      () {
        _profileImage = File(pickedImage.path);
      },
    );
    widget.onPickImage(_profileImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePhoto,
      icon: const Icon(Icons.camera),
      label: const Text('Take Photo'),
    );

    if (_profileImage != null) {
      content = GestureDetector(
        onDoubleTap: _takePhoto,
        child: Image.file(
          _profileImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: _takePhoto,
          child: CircleAvatar(
            radius: 30,
            backgroundImage:
                const AssetImage('assets/images/profile/greybackground.webp'),
            foregroundImage:
                _profileImage != null ? FileImage(_profileImage!) : null,
          ),
        ),
        const Text(
          'Tap icon to select image',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
