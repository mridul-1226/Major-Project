import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();

  static Route getRoute() {
    return MaterialPageRoute(
      builder: (context) => const RegistrationPage(),
    );
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();

  int _currentPage = 0;
  String? _selectedBranch;
  String? _selectedGender;
  String? _selectedJoiningYear;

  final List<String> _branches = ['CSE', 'EE', 'EL', 'Mining'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  // Dynamically generate years from 2015 to the present year
  List<String> _getYears() {
    int currentYear = DateTime.now().year;
    return List<String>.generate(currentYear - 2015 + 1, (index) {
      return (2015 + index).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade300, Colors.purple.shade300],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Registration',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .15,
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * .6,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        _buildPage(0, 'form1'),
                        _buildPage(1, 'form2'),
                        _buildPage(2, 'form3'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage > 0)
                          ElevatedButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue),
                            child: const Text('Previous'),
                          ),
                        if (_currentPage < 2)
                          ElevatedButton(
                            onPressed: () {
                              // Ensure the form key is not null before validating
                              if (_formKeys[_currentPage].currentState !=
                                      null &&
                                  _formKeys[_currentPage]!
                                      .currentState!
                                      .validate()) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue),
                            child: const Text('Next'),
                          ),
                        if (_currentPage == 2)
                          ElevatedButton(
                            onPressed: () {
                              bool allValid = true;
                              // Validate each form only if it's mounted and non-null
                              for (int i = 0; i < _formKeys.length; i++) {
                                if (_formKeys[i].currentState != null &&
                                    !_formKeys[i].currentState!.validate()) {
                                  allValid = false;
                                  break;
                                }
                              }
                              if (allValid) {
                                // TODO: Implement registration logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Registration')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue),
                            child: const Text('Register'),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPage(int pageIndex, String formKey) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKeys[pageIndex],
          child: Column(
            key: PageStorageKey(formKey),
            children: [
              if (pageIndex == 0) ...[
                _buildInputField('Name', _nameController),
                _buildInputField(
                    'Email', _emailController, TextInputType.emailAddress),
                _buildInputField(
                    'Mobile Number', _phoneController, TextInputType.phone),
                _buildDropdownField(
                    'Gender', _genders, (value) => _selectedGender = value),
              ],
              if (pageIndex == 1) ...[
                _buildInputField('Registration No / AKTU Roll No',
                    _registrationNumberController, TextInputType.number),
                _buildDropdownField('Year of Joining College', _getYears(),
                    (value) => _selectedJoiningYear = value),
                _buildDropdownField(
                    'Branch', _branches, (value) => _selectedBranch = value),
                _buildDateField(),
              ],
              if (pageIndex == 2) ...[
                _buildInputField("Parent's Name", _parentNameController),
                _buildInputField("Parent's Mobile Number",
                    _parentPhoneController, TextInputType.phone),
                _buildInputField(
                    'Address', _addressController, TextInputType.multiline, 3),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      [TextInputType? keyboardType, int maxLines = 1]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              if (label == 'Email' &&
                  !RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              if (label == 'Registration No / AKTU Roll No' &&
                  value.length != 13) {
                return 'Please enter a valid 13-digit registration number';
              }
              if (label == 'Mobile Number' &&
                  value.length != 10) {
                return 'Please enter a valid 10-digit mobile number';
              }
              if (label == "Parent's Mobile Number" &&
                  value.length != 10) {
                return 'Please enter a valid 10-digit mobile number';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              border: InputBorder.none,
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _dateController.text = formattedDate;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Date of Birth';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
