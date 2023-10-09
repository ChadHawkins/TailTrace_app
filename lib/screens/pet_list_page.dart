// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tracking_app/providers/pet_list_provider.dart';
// import 'package:tracking_app/models/pet.dart';
// import 'package:tracking_app/screens/add_pet_page.dart';

// class PetListPage extends StatelessWidget {
//   const PetListPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final petListProvider = Provider.of<PetListProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pet List'),
//
//       ),
//       body: FutureBuilder(
//         future: petListProvider.fetchPets(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else {
//               List<Pet> pets = petListProvider.pets;

//               if (pets.isEmpty) {
//                 return Center(
//                   child: Text('No pets found.'),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: pets.length,
//                   itemBuilder: (context, index) {
//                     Pet pet = pets[index];
//                     return ListTile(
//                       title: Text(pet.name),
//                       subtitle: Text(pet.petType),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(pet.imageUrl),
//                       ),
//                       onTap: () {},
//                     );
//                   },
//                 );
//               }
//             }
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/providers/pet_list_provider.dart';
import 'package:tracking_app/models/pet.dart';
import 'package:tracking_app/screens/add_pet_page.dart';

class PetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AddPetPage()));
            },
          ),
        ],
      ),
      body: Consumer<PetListProvider>(
        builder: (context, petListProvider, child) {
          List<Pet> pets = petListProvider.pets;

          if (pets.isEmpty) {
            return Center(
              child: Text('No pets available.'),
            );
          }

          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              Pet pet = pets[index];
              return ListTile(
                title: Text(pet.name),
              );
            },
          );
        },
      ),
    );
  }
}
