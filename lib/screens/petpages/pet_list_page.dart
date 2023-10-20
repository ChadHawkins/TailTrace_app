// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tracking_app/screens/petpages/add_pet_page.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({
    super.key,
  });

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _petsStream;

  @override
  void initState() {
    super.initState();
    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    final String userId = user!.uid;

    _petsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('pets')
        .snapshots();
  }

  void _removeItem(String petId) {
    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    final String userId = user!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('pets')
        .doc(petId)
        .delete()
        .then((value) => print('Pet deleted successfully'))
        .catchError((error) => print('Failed to delete pet: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black38,
          toolbarHeight: 40,
          title: const Center(
            child: Text(
              'Pet List',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPetPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ]),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _petsStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No pets found.'));
              }

              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot<Map<String, dynamic>> document) {
                  final Map<String, dynamic> data = document.data()!;

                  return Card(
                    color: Colors.blueGrey,
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: SizedBox(
                      height: 70,
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(
                          'Age: ${data['age']}, Type: ${data['type']}',
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['imageUrl']),
                        ),
                        trailing: IconButton(
                            onPressed: () => _removeItem(document.id),
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
