import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Other/wrapper.dart';
import 'package:tracking_app/providers/pet_details_provider.dart';
import 'package:tracking_app/providers/pet_list_provider.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final petListProvider = PetListProvider();
  await petListProvider.fetchPets();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<PetDetailsProvider>(
          create: (context) => PetDetailsProvider(),
        ),
        ChangeNotifierProvider<PetListProvider>.value(
          value: petListProvider, // Use the pre-initialized provider
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TailTrace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Wrapper(),
    );
  }
}
