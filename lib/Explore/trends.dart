import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../CustomWidgets/moreTrends.dart';

class Trends extends StatefulWidget {
  const Trends({Key? key}) : super(key: key);

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: SingleChildScrollView(
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9), // Adjust the opacity value here (0.0 to 1.0)
                  BlendMode.dstATop,
                ),// Adjust the BoxFit as needed
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back,color: Colors.white,)),
                      Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width*0.66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(61),
                          color:  Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: TextField(
                          // onChanged: filterMessages,
                          style:  TextStyle(
                            fontFamily: 'MuseoModerno',
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            icon: Padding(
                              padding:  EdgeInsets.only(left: 18.0),
                              child: SvgPicture.asset('assets/images/search-normal.svg',height: 20,),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(61)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(61)),
                            hintText: 'Search',
                            hintStyle:  TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'MuseoModerno',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset('assets/images/search-normal.svg',
                              height: 15),
                        ),
                      ),
        
                    ],
                  ),
        
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Row(children: [
                      Text('Last trends',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),),
                    ],),
                  ),
                  MoreTrends(),
        
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Row(children: [
                      Text('Food & Drinks',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),),
                    ],),
                  ),
                  MoreTrends(),
        
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Row(children: [
                      Text('Nature',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),),
                    ],),
                  ),
                  MoreTrends(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
