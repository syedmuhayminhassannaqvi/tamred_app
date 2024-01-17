import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/createPassword.dart';

class InsertEmail extends StatefulWidget {
  final String username;
  final String firstName;
  final String lastName;

  const InsertEmail({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.username,
  }) : super(key: key);

  @override
  State<InsertEmail> createState() => _InsertEmailState();
}

class _InsertEmailState extends State<InsertEmail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  String _selectedGender = 'male';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = '${picked.month}-${picked.day}-${picked.year}';
      setState(() {
        _dobController.text = formattedDate;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff222222),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 35),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(
                  children: [
                    Text(
                      'Create Your Account, ${widget.firstName}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Insert your email",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xff858585),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xffFCD240),
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.black87,
                          contentPadding: EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.017,
                            horizontal: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(
                              r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dobController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Color(0xff858585),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Color(0xffFCD240),
                                  width: 1.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.black87,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.017,
                                horizontal: 30,
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[^0-9-]')),
                              LengthLimitingTextInputFormatter(10),
                              // Format input to match "m-d-Y"
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                final regExp = RegExp(r'^\d{0,2}-\d{0,2}-\d{0,4}$');
                                if (regExp.hasMatch(newValue.text)) {
                                  // If the entered value matches the pattern, allow it
                                  return newValue;
                                } else {
                                  // Otherwise, don't allow the change
                                  return oldValue;
                                }
                              }),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a date';
                              }
                              final RegExp dateRegex = RegExp(r'^\d{1,2}-\d{1,2}-\d{4}$');

                              if (!dateRegex.hasMatch(value)) {
                                return 'Please enter a valid date in the format "m-d-Y"';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        items: <String>[
                          'male',
                          'female',
                          'other',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black87,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xff858585),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xffFCD240),
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.black87,
                          contentPadding: EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.017,
                            horizontal: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                LinearPercentIndicator(
                  lineHeight: 4,
                  backgroundColor: Colors.grey.withOpacity(0.7),
                  percent: 0.4,
                  progressColor: Colors.white,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => Create_Password(
                        username: widget.username,
                        firstname: widget.firstName,
                        lastname: widget.lastName,
                        email: _emailController.text,
                        dateOfBirth: _dobController.text,
                        gender:  _selectedGender,
                      ));
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffFCD240),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize:
                          MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
