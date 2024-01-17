import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tamred_app/profile/MapBoxViewTab.dart';
import 'package:tamred_app/profile/savedLocation.dart';
import 'package:tamred_app/profile/videoGird.dart';
import '../CustomWidgets/profileBottomSheet.dart';
import '../Mapbox/MapBoxGlobe.dart';


class profile extends StatefulWidget {
   profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BorderRadius _borderRadiusSelectedTab = BorderRadius.circular(25.0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChange);

    // Set initial border radius value
    _borderRadiusSelectedTab =  BorderRadius.only(
      topLeft: Radius.circular(25.0),
      topRight: Radius.circular(0.0),
      bottomLeft: Radius.circular(25.0),
      bottomRight: Radius.circular(0.0),
    );
  }

  void _onTabChange() {
    setState(() {
      if (_tabController.index == 0) {
        _borderRadiusSelectedTab =  BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(0.0),
        );
      } else if (_tabController.index == 1) {
        _borderRadiusSelectedTab =  BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        );
      } else if (_tabController.index == 2) {
        _borderRadiusSelectedTab = const BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(25.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(25.0),
        );
      }
    });
  }

  List<Map<String, dynamic>> data = [
    {
      'numbers': '30,2k',
      'Text': 'followers',
      'name': 'ari.grande97',
      'place': '30/203',
      'text': 'places'
    },
    {'user': 'Ariana Grande'},
    {
      'about':
          'I’m Ari and I like nature, climbing and I love talking with new people around the world.'
    }
  ];
  List<Map<String, dynamic>> images = [
    {'image': 'assets/images/user.png'}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 7, 54),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(), // Disable swipe between tabs
              children: [
                // Your tab views here
                MapBoxGlobe(),
                VideoGrid(),
                SavedLocation(),
              ],
            ),
            Positioned(
              top: 40,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/person.png',
                      height: 25,
                    ),
                    onTap: (){
                      Get.bottomSheet(
                        isDismissible: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                          ProfileBottomSheet()

                      );

                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.bottomSheet(
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.39,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            color: Colors.black,

                          ),
                          // Set the height as needed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.05,
                                    vertical:
                                    MediaQuery.of(context).size.height *
                                        0.015),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.003,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC2C2C2), // Your color
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/edit.svg',
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),                                                SizedBox(width: 10,),
                                          Text('Edit',style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.white,
                                          ),),

                                        ]
                                    ),
                                    SizedBox(height: 10,),
                                    Container(color: Colors.white,
                                      width: double.infinity,
                                      height: 0.14,
                                    ),

                                    SizedBox(height: 15,),
                                    Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/shareVideo.svg',
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Share',style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.white,
                                          ),),

                                        ]
                                    ),
                                    SizedBox(height: 10,),
                                    Container(color: Colors.white,
                                      width: double.infinity,
                                      height: 0.14,
                                    ),


                                    SizedBox(height: 15,),
                                    Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/archive-add.svg',
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Save',style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.white,
                                          ),),

                                        ]
                                    ),
                                    SizedBox(height: 10,),
                                    Container(color: Colors.white,
                                      width: double.infinity,
                                      height: 0.14,
                                    ),


                                    SizedBox(height: 15,),
                                    Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/archive.svg',
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),                                                SizedBox(width: 10,),
                                          Text('Archive',style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.white,
                                          ),),

                                        ]
                                    ),
                                    SizedBox(height: 10,),
                                    Container(color: Colors.white,
                                      width: double.infinity,
                                      height: 0.14,
                                    ),

                                    SizedBox(height: 15,),
                                    Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/delete.svg',
                                            width: 20,
                                            height: 20,
                                            color: Colors.red,
                                          ),                                                SizedBox(width: 10,),
                                          Text('Delete',style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.red,
                                          ),),

                                        ]
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ), // Add other widgets for your bottom sheet content
                            ],
                          ),
                        ),
                      );

                    },
                    child: Image.asset(
                      'assets/images/header.png',
                      height: 30,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 90,
              left: 30,
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(61),
                        color:  Color.fromRGBO(0, 0, 0, 0.5)),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[0]['numbers'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'MuseoModerno'),
                              ),
                              Text(
                                data[0]['Text'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'MuseoModerno'),
                              )
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 1,
                            color: const Color.fromRGBO(159, 159, 159, 1),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    const Text(
                                      '@',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(250, 208, 64, 1),
                                          fontSize: 16,
                                          fontFamily: 'MuseoModerno'),
                                    ),
                                    Text(
                                      data[0]['name'],
                                      style:  TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'MuseoModerno'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 1,
                            color: const Color.fromRGBO(159, 159, 159, 1),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[0]['place'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'MuseoModerno'),
                              ),
                              Text(
                                data[0]['text'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'MuseoModerno'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                    top: -40,
                    left: 122,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(
                        images[0]['image'],
                        fit: BoxFit.cover,
                      ),
                    )),
              ]),
            ),
            Positioned(
              top: 155,
              left: 130,
              child: Text(
                data[1]['user'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'MuseoModerno'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 70,top: 180,right: 50),
              child: Text(
                data[2]['about'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'MuseoModerno'),
              ),
            ),
            Positioned(
              top: 230,
              left: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                height: 40,
                width: Get.width * 0.45,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    color:  Color.fromRGBO(248, 207, 64, 1),
                    borderRadius: _borderRadiusSelectedTab,
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: _tabController.index == 0
                          ? Image.asset(
                              'assets/images/global_black.png',
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/global.png',
                              height: 30,
                            ),
                    ),
                    Tab(
                      child: _tabController.index == 1
                          ? Image.asset(
                              'assets/images/gallery.png',
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/gallery2.png',
                              height: 30,
                            ),
                    ),
                    Tab(
                      child: _tabController.index == 2
                          ? Image.asset(
                              'assets/images/archieve_black.png',
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/archieve.png',
                              height: 30,
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
