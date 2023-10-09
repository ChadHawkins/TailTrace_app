// For working with File objects for images

class Pet {
  String id;
  final String name;
  final String petType; // Define the species property
  final String breed;
  final String age;
  String imageUrl = ''; // final String color;

  Pet({
    required this.id,
    required this.name,
    required this.petType, // Make sure to include it in the constructor
    required this.breed,
    required this.age,
    required this.imageUrl,
  });
  // void updateImageUrl(String newImageUrl) {
  //   imageUrl = newImageUrl;
  // }
}
