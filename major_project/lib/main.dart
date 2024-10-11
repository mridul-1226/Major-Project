import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/auth_feature/presentation/regitartion_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MaterialApp(
      title: 'Flutter Demo',
      home: RegistrationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
