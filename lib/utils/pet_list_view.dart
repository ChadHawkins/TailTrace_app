import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/pet.dart';
import '/providers/pet_list_provider.dart';

class PetListView extends StatelessWidget {
  const PetListView({super.key});

  @override
  Widget build(BuildContext context) {
    final petListProvider = Provider.of<PetListProvider>(context);
    final List<Pet> pets = petListProvider.pets;

    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return Card(
          child: ListTile(
            // leading: Image.network(pet.imageUrl),
            // leading: pet.imageUrl.isNotEmpty
            //     ? Image.network(
            //         pet.imageUrl,
            //         width: 100, // Adjust the image width as needed
            //         height: 100, // Adjust the image height as needed
            //         fit: BoxFit.cover, // Choose the appropriate BoxFit
            //       )
            //     : Container(
            //         width: 100,
            //         height: 100,
            //         color: Colors.grey, // Placeholder color
            //         child: Icon(
            //           Icons.image,
            //           color: Colors.white,
            //         ),
            //       ),
            title: Text('Name: ${pet.name}'),
            subtitle: Text(
                'Age: ${pet.age}, Breed: ${pet.breed}, Type: ${pet.petType}'),
          ),
        );
      },
    );
  }
}
