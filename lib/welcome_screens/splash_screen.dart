import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamred_app/registration_Screen/login.dart';
import 'package:tamred_app/welcome_screens/welcomeOne.dart';
import 'package:tamred_app/welcome_screens/welcome_PageView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.to(Welcome_PageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Color(0xff222222),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tamred',style: TextStyle(
              fontFamily: 'MuseoModerno',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width*0.077
          ),),
          Icon(Icons.location_on_sharp,color: Colors.red,size: MediaQuery.of(context).size.width*0.07,)
        ],
      ),

    );
  }
}
