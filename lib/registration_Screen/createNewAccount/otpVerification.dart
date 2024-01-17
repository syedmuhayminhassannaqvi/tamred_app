import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:tamred_app/registration_Screen/login.dart';

import 'let_explore.dart';

class OTP_Verification extends StatefulWidget {
  String token;
  String email;
   OTP_Verification({
    Key? key,required this.email,required this.token
  }) : super(key: key);

  @override
  State<OTP_Verification> createState() => _OTP_VerificationState();
}

class _OTP_VerificationState extends State<OTP_Verification> {
  bool _isVerifying = false;



  Future<void> verifyOTP(String email, String enteredOTP, String token) async {
    setState(() {
      _isVerifying = true; // Set the verifying state to true while sending the request
    });
    String baseURL = "https://morally-smiling-viper.ngrok-free.app/api";
    String url = '$baseURL/email/verification/request';

    Map<String, String> body = {
      'email': email,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('Email verification successful');

        Get.to(Lets_Explore());

      } else {
        setState(() {
          _isVerifying = true; // Set the verifying state to true while sending the request
        });
        print('Failed email verification . Error: ${response.body}');
      }
    } catch (error, stackTrace) {
      print('Caught error: $error');
      print('Stack trace: $stackTrace');
      throw Exception('Error verifying OTP: $error');
    }
  }

  List<String> otpDigits = List.filled(4, '');

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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Row(
                children: [
                  Text(
                    "Create Your Account",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.08),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '_',
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      maxLength: 1,
                      style: TextStyle(fontSize: 14.0), // Adjust font size
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          otpDigits[index] = value; // Update the digit at the specific index
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ).expand((widget) => [widget, Spacer()]).toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              LinearPercentIndicator(
                lineHeight: 4,
                backgroundColor: Colors.grey.withOpacity(0.7),
                percent: 1,
                progressColor: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              _isVerifying // Check if verification is in progress
                  ? CircularProgressIndicator(
                color: Color(0xffFCD240),
              ) // Show circular progress indicator
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  String enteredOTP = otpDigits.join(); // Concatenate entered OTP
                  if (enteredOTP.length == 4) {
                    verifyOTP(widget.email, enteredOTP, widget.token);
                  } else {
                    print('length not right');
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
                      "Next",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
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
