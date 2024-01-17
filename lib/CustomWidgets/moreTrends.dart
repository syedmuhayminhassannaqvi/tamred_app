import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MoreTrends extends StatefulWidget {
   MoreTrends({Key? key}) : super(key: key);

  @override
  State<MoreTrends> createState() => _MoreTrendsState();
}

class _MoreTrendsState extends State<MoreTrends> {
  List<String> imagePaths = [
    'assets/images/ExploreCityone.png',
    'assets/images/ExploreCitySecond.png',
    'assets/images/ExploreCityone.png',
    'assets/images/ExploreCitySecond.png',
    'assets/images/ExploreCityone.png',
    'assets/images/ExploreCitySecond.png',
    'assets/images/ExploreCityone.png',
    'assets/images/ExploreCitySecond.png',
    // Add more image paths as needed
  ];
  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: Get.height*0.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(imagePaths[index]),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.14,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/images/human.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.03,
                        top: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/play.svg',
                              width: 15,
                              height: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              '2,2M',
                              style: TextStyle(
                                fontFamily: 'MuseoModerno',
                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.08,
                        left: MediaQuery.of(context).size.width * 0.014,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Jawa Tengah',
                                  style: TextStyle(
                                    fontFamily: 'MuseoModerno',
                                    fontSize: MediaQuery.of(context).size.height * 0.013,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/location.png',color: Colors.white,width: 12,),
                                Text(
                                  'Jawa Tengah',
                                  style: TextStyle(
                                    fontFamily: 'MuseoModerno',
                                    fontSize: MediaQuery.of(context).size.height * 0.013,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
