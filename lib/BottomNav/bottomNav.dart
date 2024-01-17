import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tamred_app/Explore/exploreSection.dart';
import 'package:tamred_app/messages/messageSection.dart';
import 'package:tamred_app/profile/profile.dart';
import 'package:tamred_app/videoplayer/videoPlayer.dart';
import '../Carica/upload_section.dart';
import '../Mapbox/MapBoxGlobe.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    VideoScreen(),
    MessageSection(),
    ExploreSection(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<String> svgImages = [
    'assets/images/home-2.svg',
    'assets/images/direct-notification.svg',
    'assets/images/search-normal.svg',
    'assets/images/profile.svg',
  ];

  List<String> texts = [
    'Home',
    'Inbox',
    'Explore',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: ClipPath(
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.23,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 2; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _onItemTapped(i);
                            },
                            child: SvgPicture.asset(
                              svgImages[i],
                              width: MediaQuery.of(context).size.width * 0.073,
                              color: _currentIndex == i
                                  ? Colors.white
                                  : Colors
                                      .grey, // Update color based on selection
                            ),
                          ),
                          Text(
                            texts[i],
                            style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: _currentIndex == i
                                  ? Colors.white
                                  : Colors
                                      .grey, // Update color based on selection
                            ),
                          ),
                        ],
                      ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    for (int i = 2; i < svgImages.length; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _onItemTapped(i);
                            },
                            child: SvgPicture.asset(
                              svgImages[i],
                              width: MediaQuery.of(context).size.width * 0.073,
                              color: _currentIndex == i
                                  ? Colors.white
                                  : Colors
                                      .grey, // Update color based on selection
                            ),
                          ),
                          Text(
                            texts[i],
                            style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: _currentIndex == i
                                  ? Colors.white
                                  : Colors
                                      .grey, // Update color based on selection
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          clipper: CurveDraw(),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
        ),
        child: MaterialButton(
          color: Color(0xff27BDDE),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          onPressed: () {
            Get.to(UploadMedia());
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: MediaQuery.of(context).size.width * 0.1,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CurveDraw extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double sw = size.width;
    double sh = size.height;
    double curveHeight = sh / 2.2; // Reduce this value for less curve

    Path path = Path();
    path.moveTo(0, sh);
    path.lineTo(0, curveHeight);
    path.quadraticBezierTo(0, 0, curveHeight, 0); // 1st curve
    path.lineTo(sw / 2 - sw / 5, 0);
    path.cubicTo(
        sw / 2 - sw / 12, 0, sw / 2 - sw / 8, curveHeight, sw / 2, curveHeight);
    path.cubicTo(
        sw / 2 + sw / 10, curveHeight, sw / 2 + sw / 10, 0, sw / 2 + sw / 5, 0);
    path.lineTo(sw - curveHeight, 0);
    path.quadraticBezierTo(sw, 0, size.width, curveHeight);
    path.lineTo(size.width, size.height - curveHeight);
    path.quadraticBezierTo(
        size.width, size.height, size.width - curveHeight, size.height);
    path.lineTo(curveHeight, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - curveHeight);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
