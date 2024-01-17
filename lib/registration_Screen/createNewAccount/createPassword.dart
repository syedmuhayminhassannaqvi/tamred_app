import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'NickName.dart';

class Create_Password extends StatefulWidget {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String dateOfBirth;
  final String gender;
  const Create_Password({Key? key, required this.firstname, required this.lastname, required this.email, required this.dateOfBirth, required this.gender, required this.username}) : super(key: key);

  @override
  State<Create_Password> createState() => _Create_PasswordState();
}

class _Create_PasswordState extends State<Create_Password> {

  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xff222222),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,color: Colors.white,size: 35,),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Row(
                children: [
                  Text("Create Your Account",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width*0.05
                  ),),
                ],
              ),
              Row(
                children: [
                  Text("Create a password",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.08
                  ),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      // Hide or show password based on toggle
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                          vertical: MediaQuery.of(context).size.height * 0.017,
                          horizontal: 30,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password should be at least 6 characters';
                        }
                        return null; // Return null for no validation error
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      style: TextStyle(color: Colors.white),
                       // Hide or show password based on toggle
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                          vertical: MediaQuery.of(context).size.height * 0.017,
                          horizontal: 30,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password again';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null; // Return null for no validation error
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              LinearPercentIndicator(
                lineHeight: 4,
                percent: 0.6,
                backgroundColor: Colors.grey.withOpacity(0.7),
                progressColor: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.to(() => Choose_Nickname(
                      firstName: widget.firstname,
                      lastName: widget.lastname,
                      email: widget.email,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                      username: widget.username,
                      gender: widget.gender,
                      dateOfBirth: widget.dateOfBirth,
                    ));
                    // Proceed if the form is valid
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFCD240),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Center(
                    child: Text("Next",style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.05
                    ),),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
