import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tamred_app/BottomNav/bottomNav.dart';
import 'package:tamred_app/registration_Screen/forget_Password.dart';
import 'package:http/http.dart' as http;

import '../Mapbox/MapBoxGlobe.dart';
import 'createNewAccount/enterName.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe; // Toggle the boolean value
    });
  }


  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    final baseUrl = "https://morally-smiling-viper.ngrok-free.app/api";

    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Successful login, handle response
      print('Login successful: ${response.body}');
      Get.to(BottomNavigator());

    } else {
      // Handle login failure
      throw Exception("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xff222222),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tamred',
                      style: TextStyle(
                          fontFamily: 'MuseoModerno',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.077),
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width * 0.07,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.017, horizontal: 30),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20, // Adjust the height as needed
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.017, horizontal: 30),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        // Replace the Icon widget with SvgPicture.asset
                        GestureDetector(
                          onTap: _toggleRememberMe,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                _rememberMe
                                    ? 'assets/images/checked.svg'
                                    : 'assets/images/unchecked.svg',
                                width: 24, // Set the width as per your requirement
                                height: 24, // Set the height as per your requirement
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.015,
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(Forget_Password());
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(EnterName());

                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 0.8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
          
                      // Check for empty fields before attempting login
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Please try again",
                          "Fill both email and password",
                          duration: Duration(seconds: 10),
                          snackStyle: SnackStyle.FLOATING,
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                        );
                      } else {
                        try {
                          await loginUser(email, password);
                        } catch (e) {
                          
                          Get.snackbar(
                            "Please try again",
                            "Invalid Email or Password",
                            duration: Duration(seconds: 10),
                            snackStyle: SnackStyle.FLOATING,
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                          );
                        }
                      }
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffFCD240),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
