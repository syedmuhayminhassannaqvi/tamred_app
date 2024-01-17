import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tamred_app/CustomWidgets/filters.dart';
import 'package:tamred_app/registration_Screen/login.dart';
import '../../welcome_screens/welcomeSecond.dart';

class Favourite_place extends StatefulWidget {
  const Favourite_place({Key? key}) : super(key: key);

  @override
  State<Favourite_place> createState() => _Favourite_placeState();
}

class _Favourite_placeState extends State<Favourite_place> {
  List<bool> isSelected = List.generate(6, (index) => false);

  final List<String> imagePaths = [
    'assets/images/tree.png',
    'assets/images/volcano.png',
    'assets/images/mountain.png',
    'assets/images/plant.png',
    'assets/images/tent.png',
    'assets/images/wheat.png',
    // Add more image paths here as needed
  ];

  final List<String> imageaName = [
    "Tree",
    "Volcano",
    "Mountain",
    "Plant",
    "Tent",
    "wheat",
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xff222222),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.07,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Where is your favourite\nplace to explore?",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Filters(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                GestureDetector(
                  onTap: () {
                    Get.to(Login_Screen());
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
                        "Finish!",
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
