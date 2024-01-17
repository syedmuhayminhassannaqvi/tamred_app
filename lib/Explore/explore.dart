import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tamred_app/CustomWidgets/moreTrends.dart';
import 'package:tamred_app/Explore/trends.dart';

import '../CustomWidgets/trendConatiner.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late PageController _pageController;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Explore.png'),
                    fit: BoxFit.cover,
                  ),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Nature trips',style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'MuseoModerno',
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),),
                    Text('Explore the deserts',style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'MuseoModerno',
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,)
                  ],
                ),
              ),
              // SmoothPageIndicator(
              //   controller: _pageController,
              //   count: 4,
              //   effect: ScaleEffect(
              //     activeDotColor: Colors.white,
              //     dotColor: Colors.white.withOpacity(0.6),
              //     dotWidth: 5.0,
              //     dotHeight: 5.0,
              //     spacing: 7.0,
              //   ), // Change effect as needed
              // ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02,horizontal: MediaQuery.of(context).size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Last trends',style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'MuseoModerno',
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Get.to(Trends());
                      },
                      child: Text('See All   >',style: TextStyle(
                        color: Color(0xffF8CF40),
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),),
                    ),

                  ],),
              ),

              MoreTrends(),
              SizedBox(  height: MediaQuery.of(context).size.height * 0.05,),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02,right: MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  children: [
                    Row(children: [
                      Text('Suggestion for you',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),),
                    ],),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 18.0, // Spacing between columns
                          mainAxisSpacing: 18.0, // Spacing between rows
                        ),
                        itemCount: 8, // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/mountainsExplore.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 18.0,bottom: 10),
                                    child: Text(
                                      'Taste the Tradition',
                                      style: TextStyle(
                                        fontFamily: 'MuseoModerno',
                                        fontSize: MediaQuery.of(context).size.height * 0.013,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )

                          );
                        },
                      ),
                    )

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
