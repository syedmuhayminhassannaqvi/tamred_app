import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tamred_app/registration_Screen/login.dart';

class OTPAndNewPasswordScreen extends StatefulWidget {
  String email;

   OTPAndNewPasswordScreen({Key? key,required this.email}) : super(key: key);

  @override
  State<OTPAndNewPasswordScreen> createState() => _OTPAndNewPasswordScreenState();
}

class _OTPAndNewPasswordScreenState extends State<OTPAndNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  List<String> otpDigits = List.filled(4, '');
  bool _isVerifying = false;

  Future<void> resetPassword(String email, List<String> otpDigits, String newPassword, String confirmPassword) async {
    setState(() {
      _isVerifying = true;
    });

    final baseUrl = "https://morally-smiling-viper.ngrok-free.app/api";
    final url = Uri.parse('$baseUrl/password/reset');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
        'otp': otpDigits.join(''),
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
    );

    setState(() {
      _isVerifying = false;
    });

    if (response.statusCode == 200) {
      Get.snackbar(
        "successfully",
        "Password have changed ",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );

      // Password reset successful, navigate to the desired screen
      // e.g., navigate to a success screen or login screen
      print('success');
      Get.to(Login_Screen());

      // Get.to(Login_Screen()); // Replace LoginScreen with your desired screen
    } else {
      Get.snackbar(
        "Try Again",
        "Password reset failed",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      print('Password reset failed');
    }
  }

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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 35),
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
                    style: TextStyle(fontFamily: 'Urbanist', color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(fontFamily: 'Urbanist', color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.08),
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      maxLength: 1,
                      style: TextStyle(fontSize: 14.0),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          otpDigits[index] = value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ).expand((widget) => [widget, Spacer()]).toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              _isVerifying
                  ? CircularProgressIndicator(color: Color(0xffFCD240))
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                        labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Color(0xff858585), width: 1.0)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Color(0xffFCD240), width: 1.0)),
                        filled: true,
                        fillColor: Colors.black87,

                      ),

                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      controller: _repeatPasswordController,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null; // Return null if validation succeeds
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Repeat Password',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
                        labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Color(0xff858585), width: 1.0)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Color(0xffFCD240), width: 1.0)),
                        filled: true,
                        fillColor: Colors.black87,

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    resetPassword(
                      widget.email,
                      otpDigits,
                      _passwordController.text,
                      _repeatPasswordController.text,
                    );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffFCD240), borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(fontFamily: 'Urbanist', fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
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
