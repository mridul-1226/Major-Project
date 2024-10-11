import 'package:flutter/material.dart';
import 'package:major_project/auth_feature/presentation/regitartion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: RegistrationPage(),
    );
  }
}
