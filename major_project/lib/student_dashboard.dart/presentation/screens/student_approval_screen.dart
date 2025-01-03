import 'package:flutter/material.dart';
import 'package:major_project/student_dashboard.dart/presentation/screens/student_dashboard_screen.dart';
import 'package:major_project/student_dashboard.dart/presentation/widgets/student_card.dart';

import '../widgets/registration_status_dialog.dart';

class StudentApprovalScreen extends StatelessWidget {
  const StudentApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Dashboard'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Registration Form',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              const StudentCard(
                name: 'name',
                fatherName: 'fatherName',
                regNumber: 'regNumber',
                collegeName: 'collegeName',
                branch: 'branch',
                year: 'year',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => RegistrationStatusDialog(
                          isApproved: true,
                          studentName: "John Doe",
                          onNext: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StudentDashboardScreen(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Show Approval Status',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }
}
