import 'package:flutter/material.dart';
import 'dart:io';

class PetDetailsProvider extends ChangeNotifier {
  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petTypeController = TextEditingController();
  File? get petImage => _petImage;
  File? _petImage;

  int _petAge = 0;
  String _petName = '';
  String _petBreed = '';
  String _petType = '';

  int get petAge => _petAge;
  String get petName => _petName;
  String get petBreed => _petBreed;
  String get petType => _petType;

  void updatePetImage(File image) {
    _petImage = image;
    notifyListeners();
  }

  void updatePetAge(int petAge) {
    _petAge = petAge;
    notifyListeners();
  }

  void updatePetName(String petName) {
    _petName = petName;
    notifyListeners();
  }

  void updatePetBreed(String petBreed) {
    _petBreed = petBreed;
    notifyListeners();
  }

  void updatePetType(String petType) {
    _petType = petType;
    notifyListeners();
  }

  bool isValidPet() {
    final petName = petNameController.text.trim();
    final petAge = petAgeController.text.trim();
    final petBreed = petBreedController.text.trim();
    final petType = petTypeController.text.trim();

    return petName.isNotEmpty &&
        petAge.isNotEmpty &&
        petBreed.isNotEmpty &&
        petType.isNotEmpty;
  }

  void clearPetDetails() {
    petNameController.clear();
    petAgeController.clear();
    petBreedController.clear();
    petTypeController.clear();
  }
}
