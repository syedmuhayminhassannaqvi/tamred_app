import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tamred_app/CustomWidgets/triangle.dart';

class MapSlider extends StatefulWidget {
  const MapSlider({Key? key}) : super(key: key);

  @override
  State<MapSlider> createState() => _MapSliderState();
}

class _MapSliderState extends State<MapSlider> {
  List<Map<String, dynamic>> layout = [
    {
      'Image': 'assets/images/branch.png',
      'Text':
      'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to Lake is in the middle of the most famose Natural Park in Canada, close to'
    },
    {
      'Image': 'assets/images/branch.png',
      'Text':
      'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
    },
    {
      'Image': 'assets/images/branch.png',
      'Text':
      'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
    },
    {
      'Image': 'assets/images/branch.png',
      'Text':
      'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
    },
    {
      'Image': 'assets/images/branch.png',
      'Text':
      'The Frozen Lake is in the middle of the most famose Natural Park in Canada, close to...'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom: Get.height*0.14,
      child: SizedBox(
        height: Get.height*0.2,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            aspectRatio: 2.0, // Adjust aspect ratio for desired item shape
            scrollDirection: Axis.horizontal,
          ),
          items: layout.map((item) {
            return Column(
              children: [
                Container(
                  child: CustomPaint(
                    painter: DrawTriangle(),
                  ),
                  height: 10,
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                    color: Color(0xff46515f).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(item['Image'], fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Belle Vue Sur Le Lac Morainesvcewbhagrsufhgeurckenigvesaugfveruibveu',
                                          maxLines: 1,
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white,
                                            color: Colors.white,
                                            fontFamily: 'MuseoModerno',
                                            fontWeight: FontWeight.w900,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 13,
                                          ),
                                        ),
                                        width:
                                        MediaQuery.of(context).size.width * 0.45,
                                      ),
                                      Icon(
                                        Icons.clear,
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item['Text'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'MuseoModerno',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 4,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
