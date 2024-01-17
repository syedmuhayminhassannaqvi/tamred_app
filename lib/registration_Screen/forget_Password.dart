import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tamred_app/welcome_screens/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'create_NewPassword.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({Key? key}) : super(key: key);

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  bool _isVerifying = false;



  Future<void> forgotPassword(String email) async {
    setState(() {
      _isVerifying = true; // Set the verifying state to true while sending the request
    });
    final baseUrl = "https://morally-smiling-viper.ngrok-free.app/api";
    final url = Uri.parse('$baseUrl/password/forgot');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      // Email exists, navigate to the page for creating a new password
      print('OtP send to Email');
      Get.snackbar(
        "Email",
        "OTP is Send To your email",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      Get.to(OTPAndNewPasswordScreen(email: _emailController.text,

      ));

    } else {
      // Email doesn't exist, show an error message
      print('Email donot Exist');
      setState(() {
        _isVerifying = false; // Set the verifying state to true while sending the request
      });
      Get.snackbar(
        "Error",
        "This Email does not exit.",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

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
                  Text("Input Your Email",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width*0.05
                  ),),
                ],
              ),
              Row(
                children: [
                  Text("Forget Your password?",style: TextStyle(
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
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        isDense: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 30),
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
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Adjust the height as needed
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              _isVerifying // Check if verification is in progress
                  ? CircularProgressIndicator(
                color: Color(0xffFCD240),
              ) // Show circular progress indicator
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    String enteredEmail = _emailController.text;
                    forgotPassword(enteredEmail);
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
                    child: Text("Submit",style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.05
                    ),),
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
