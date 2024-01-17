import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../welcome_screens/welcomeSecond.dart';
import 'favourite_category.dart';

class Lets_Explore extends StatefulWidget {
  const Lets_Explore({Key? key}) : super(key: key);

  @override
  State<Lets_Explore> createState() => _Lets_ExploreState();
}

class _Lets_ExploreState extends State<Lets_Explore> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Material(
        color: Color(0xff222222),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/earth.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04,vertical: MediaQuery.of(context).size.height*0.14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("Successfully created an \naccount",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: MediaQuery.of(context).size.width*0.08
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text("After this you can explore any\nplace you want!",style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.05
                    ),),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                GestureDetector(
                  onTap: (){
                    Get.to(Favourite_place());

                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffFCD240),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Center(
                      child: Text("Let's Explore!",style: TextStyle(
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
      ),
    );
  }
}
