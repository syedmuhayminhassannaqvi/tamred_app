import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Itinerary.dart';
import 'filterCategory.dart';

class AlbumSearch extends StatefulWidget {
  const AlbumSearch({Key? key}) : super(key: key);

  @override
  State<AlbumSearch> createState() => _AlbumSearchState();
}

class _AlbumSearchState extends State<AlbumSearch> {
  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();

  List<int> selectedIndices = [];



  List<Map<String, dynamic>> thumbnails = [
    {'image': 'assets/images/ele.png'},
    {'image': 'assets/images/des.png'},
    {'image': 'assets/images/moun.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/ele.png'},
    {'image': 'assets/images/des.png'},
    {'image': 'assets/images/moun.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/isl.png'},
    {'image': 'assets/images/ele.png'},
    {'image': 'assets/images/des.png'},
    {'image': 'assets/images/moun.png'},
    {'image': 'assets/images/isl.png'}
  ];


  List<Map<String, dynamic>> getEvenIndexThumbnails(List<Map<String, dynamic>> list) {
    return List<Map<String, dynamic>>.generate(list.length ~/ 2, (index) => list[index * 2]);
  }

  List<Map<String, dynamic>> getOddIndexThumbnails(List<Map<String, dynamic>> list) {
    return List<Map<String, dynamic>>.generate(list.length ~/ 2, (index) => list[index * 2 + 1]);
  }



  @override
  void initState() {
    super.initState();
    _controller1.addListener(_scrollListener);
    _controller2.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller1.position.userScrollDirection == ScrollDirection.forward ||
        _controller1.position.userScrollDirection == ScrollDirection.reverse) {
      _controller2.jumpTo(_controller1.position.pixels);
    } else if (_controller2.position.userScrollDirection == ScrollDirection.forward ||
        _controller2.position.userScrollDirection == ScrollDirection.reverse) {
      _controller1.jumpTo(_controller2.position.pixels);
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> evenIndexThumbnails = getEvenIndexThumbnails(thumbnails);
    List<Map<String, dynamic>> oddIndexThumbnails = getOddIndexThumbnails(thumbnails);
    return  SafeArea(
      child: Material(
        child: Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
                fit: BoxFit.cover, // Adjust the BoxFit as needed
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/tokyo.png'),
                        fit: BoxFit.cover,
                      ),

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
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
                              GestureDetector(
                                onTap: (){
                                  Get.bottomSheet(
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.31,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        color: Colors.black,
                                      ),                                  // Set the height as needed
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
                                                      ),                                                SizedBox(width: 10,),
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
                                child: SvgPicture.asset(
                                  'assets/images/more.svg',
                                  width: 35,
                                  height: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                'Tokyo,Japan',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize: MediaQuery.of(context).size.height * 0.03,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.22,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Text(
                                '560 media',
                                style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize: MediaQuery.of(context).size.height * 0.014,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height* 0.06,
                        width: MediaQuery.of(context).size.width / 1.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(61),
                          color: Colors.black,
                        ),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Museo',
                            fontWeight: FontWeight.w700,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(61),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(61),
                            ),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Museo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: (){
                          Get.to(FilterCategory());
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25,
                          child: Image.asset(
                            'assets/images/edit.png',
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: MasonryGridView.count(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: thumbnails.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndices.contains(index);
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1.3,
                                  ),
                                ),
                                child: Image.asset(thumbnails[index]['image']),
                              ),
                              Positioned(
                                left: 12,
                                top: 10,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/play.svg',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      '2,2M',
                                      style: TextStyle(
                                        fontFamily: 'MuseoModerno',
                                        fontSize: MediaQuery.of(context).size.height * 0.02,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 14,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '22 MAY',
                                          style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.017,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Jawa Tengah',
                                          style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.017,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/location.png',
                                          color: Colors.white,
                                          width: 12,
                                        ),
                                        Text(
                                          'Jawa Tengah',
                                          style: TextStyle(
                                            fontFamily: 'MuseoModerno',
                                            fontSize: MediaQuery.of(context).size.height * 0.017,
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
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0,left: 10,right: 10
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        Get.to(CreateItinerary());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffFCD240),
                            borderRadius: BorderRadius.all(Radius.circular(17))),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/routing.svg',
                                width: 20,
                                height: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 15,),
                              Text(
                                "Create Intinerary",
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.width * 0.05),
                              ),
                            ],
                          ),
                        ),
                      ),),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
