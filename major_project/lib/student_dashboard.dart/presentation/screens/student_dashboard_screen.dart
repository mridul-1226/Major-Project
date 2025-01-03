import 'package:flutter/material.dart';

import 'fee_card.dart';

enum FeeStatus { lessThanFifty, betweenFiftyAndNinety, complete }

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  String? selectedSemester;

  final List<String> semesters = [
    '1st Semester',
    '2nd Semester',
    '3rd Semester',
    '4th Semester',
    '5th Semester',
    '6th Semester',
    '7th Semester',
    '8th Semester',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Dashboard'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1a237e), Color(0xFF3949ab)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color(0xFF1a237e),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.arrow_drop_down, color: Colors.white),
                    ),
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Select Semester',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    value: selectedSemester,
                    items: semesters.map((String semester) {
                      return DropdownMenuItem<String>(
                        value: semester,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            semester,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSemester = newValue;
                      });
                    },
                  ),
                ),
              ),

              // Fee Card
              if (selectedSemester != null) FeeCard(semester: selectedSemester!)
            ],
          ),
        ));
  }
}
