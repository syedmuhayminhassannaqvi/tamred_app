import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tamred_app/CustomWidgets/filters.dart';

class FilterCategory extends StatefulWidget {
  const FilterCategory({Key? key}) : super(key: key);

  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: SafeArea(
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
                fit: BoxFit.cover, // Adjust the BoxFit as needed
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          'assets/images/arrow-circle-left.svg',
                          width: 35,
                          height: 35,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/header.png',
                        width: 35,
                        height: 35,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Filter your media',style: TextStyle(
                    fontFamily: 'MuseoModerno',
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.white,
                  ),),
                  Text('Filter your research to find the perfect place',style: TextStyle(
                      fontFamily: 'MuseoModerno',
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis
                  ),),
                  SizedBox(height: 20,),
                  Filters(),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
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
      ),
    );
  }
}
