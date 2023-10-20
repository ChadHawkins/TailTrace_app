import 'package:flutter/material.dart';
import 'package:tracking_app/screens/petpages/pet_list_page.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 250,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListTile(
            subtitle: PetListPage(),
          ),
        ),
      ),
    );
  }
}
