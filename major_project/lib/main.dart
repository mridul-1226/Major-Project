import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/auth_feature/presentation/screens/login_screen.dart';
import 'package:major_project/student_dashboard.dart/presentation/screens/student_approval_screen.dart';
import 'package:major_project/student_dashboard.dart/presentation/screens/student_dashboard_screen.dart';

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
      // home: FeesScreen(),
      home: StudentDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
