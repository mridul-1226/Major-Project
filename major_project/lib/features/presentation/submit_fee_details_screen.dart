// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class FeesScreen extends StatefulWidget {
//   const FeesScreen({Key? key}) : super(key: key);

//   @override
//   State<FeesScreen> createState() => _FeesScreenState();
// }

// class _FeesScreenState extends State<FeesScreen> {
//   String? selectedFeesType;
//   final TextEditingController amountController = TextEditingController();
//   bool isFeesFullySubmitted = false;

//   final List<String> feesTypes = [
//     'Mess Fee',
//     'College Fee',
//     'Additional Charges',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fees Submission'),
//           elevation: 0,
//         ),
//         backgroundColor: Colors.grey[100],
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'Submit Fees',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         labelText: 'Fees Type',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[50],
//                       ),
//                       value: selectedFeesType,
//                       items: feesTypes.map((String type) {
//                         return DropdownMenuItem(
//                           value: type,
//                           child: Text(type),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedFeesType = newValue;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       controller: amountController,
//                       decoration: InputDecoration(
//                         labelText: 'Submitted Amount',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[50],
//                         prefixIcon: const Icon(Icons.currency_rupee),
//                         // Add these properties to handle hover states properly
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide:
//                               BorderSide(color: Theme.of(context).primaryColor),
//                         ),
//                       ),
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: false),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       // Add these properties for better input handling
//                       enabled: true,
//                       mouseCursor: MaterialStateMouseCursor.textable,
//                       onTap: () {
//                         // Ensure proper focus handling
//                         FocusScope.of(context).requestFocus();
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Fees Fully Submitted',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[50],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Row(
//                         children: [
//                           Radio<bool>(
//                             value: true,
//                             groupValue: isFeesFullySubmitted,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isFeesFullySubmitted = value!;
//                               });
//                             },
//                           ),
//                           const Text('Yes'),
//                           const SizedBox(width: 20),
//                           Radio<bool>(
//                             value: false,
//                             groupValue: isFeesFullySubmitted,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isFeesFullySubmitted = value!;
//                               });
//                             },
//                           ),
//                           const Text('No'),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Add your submission logic here
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Submit',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  String? selectedFeesType;
  final TextEditingController amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  bool isFeesFullySubmitted = false;

  final List<String> feesTypes = [
    'Mess Fee',
    'College Fee',
    'Additional Charges',
  ];
  @override
void dispose() {
  _amountFocusNode.dispose();
  amountController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fees Submission'),
          elevation: 0,
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.blue.shade50, // Soft blue background
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Submit Fees',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Fees Type',
                        labelStyle: TextStyle(color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.blue.shade50,
                      ),
                      value: selectedFeesType,
                      items: feesTypes.map((String type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFeesType = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // First, add this to your class state variables


// In your build method, replace the TextFormField with:
TextField(
  controller: amountController,
  focusNode: _amountFocusNode,
  decoration: InputDecoration(
    labelText: 'Submitted Amount',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    fillColor: Colors.grey[50],
    prefixIcon: const Icon(Icons.currency_rupee),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
),

// Add dispose method to your state class:


                    const SizedBox(height: 24),
                    const Text(
                      'Fees Fully Submitted',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isFeesFullySubmitted,
                            onChanged: (bool? value) {
                              setState(() {
                                isFeesFullySubmitted = value!;
                              });
                            },
                          ),
                          const Text(
                            'Yes',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          const SizedBox(width: 20),
                          Radio<bool>(
                            value: false,
                            groupValue: isFeesFullySubmitted,
                            onChanged: (bool? value) {
                              setState(() {
                                isFeesFullySubmitted = value!;
                              });
                            },
                          ),
                          const Text(
                            'No',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 16,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.85, // 85% of screen width
                                  constraints: BoxConstraints(
                                    maxWidth: 400, // Maximum width
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.25, // Minimum height
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.8, // Maximum height
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 60,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      const Text(
                                        'Processing',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015),
                                      const Text(
                                        'Your submission is under process.\nPlease wait for approval.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          // : Colors.blueAccent, // Bluish button color
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
