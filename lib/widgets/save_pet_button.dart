import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/providers/pet_list_provider.dart';
import 'package:tracking_app/models/pet.dart';

void savePet(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController typeController,
  TextEditingController breedController,
  TextEditingController ageController,
  bool isImageSelected,
  String imageUrl,
) async {
  final String name = nameController.text.trim();
  final String type = typeController.text.trim();
  final String breed = breedController.text.trim();
  final int age = int.tryParse(ageController.text.trim()) ?? 0;

  final List<String> missingFields = [];

  if (name.isEmpty) {
    missingFields.add('Name');
  }
  if (type.isEmpty) {
    missingFields.add('Type');
  }
  if (breed.isEmpty) {
    missingFields.add('Breed');
  }
  if (age <= 0) {
    missingFields.add('Age');
  }
  if (!isImageSelected) {
    missingFields.add('Photo');
  }

  if (missingFields.isEmpty) {
    final Pet newPet = Pet(
      name: name,
      age: age.toString(),
      breed: breed,
      petType: type,
      id: '',
      imageUrl: imageUrl,
    );

    final petListProvider =
        Provider.of<PetListProvider>(context, listen: false);

    await petListProvider.addPet(newPet);
    await petListProvider.fetchPets();

    nameController.clear();
    typeController.clear();
    breedController.clear();
    ageController.clear();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet saved successfully.'),
      ),
    );

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Please fill in or select the following fields: ${missingFields.join(", ")}',
        ),
      ),
    );
  }
}
