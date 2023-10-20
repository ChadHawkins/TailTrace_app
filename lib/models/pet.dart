// ignore_for_file: constant_identifier_names

import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum TypeOfPet { Dog, Cat }

class Pet {
  Pet({
    required this.type,
    required this.name,
    required this.age,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double age;
  final Type type;
  // final String image;
}
