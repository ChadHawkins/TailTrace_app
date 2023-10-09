import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracking_app/models/pet.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class PetListProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  List<Pet> _pets = [];

  List<Pet> get pets => _pets;

  Future<void> fetchPets() async {
    final auth.User? user = _auth.currentUser;

    if (user != null) {
      final String userId = user.uid;

      final QuerySnapshot querySnapshot = await _firestore
          .collection('pets')
          .where('userId', isEqualTo: userId)
          .get();

      _pets = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Pet(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          age: data['age'] ?? 0,
          breed: data['breed'] ?? '',
          petType: data['type'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();
      notifyListeners();
    }
  }

  Future<void> addPet(Pet pet) async {
    final auth.User? user = _auth.currentUser;

    if (user != null) {
      final String userId = user.uid;
      final CollectionReference userPetsCollection =
          _firestore.collection('users').doc(userId).collection('pets');

      try {
        final DocumentReference petDocRef = await userPetsCollection.add({
          'name': pet.name,
          'age': pet.age,
          'breed': pet.breed,
          'type': pet.petType,
        });

        pet.id = petDocRef.id;

        _pets.add(pet);
        notifyListeners();
      } catch (e) {
        // ignore: avoid_print
        print("Error adding pet: $e");
      }
    }
  }
}
