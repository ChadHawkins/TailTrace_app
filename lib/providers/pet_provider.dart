// ignore_for_file: non_constant_identifier_names

import 'package:riverpod/riverpod.dart';
import 'package:tracking_app/models/pet.dart';

final PetProvider = Provider(
  (ref) {
    return Pet;
  },
);
