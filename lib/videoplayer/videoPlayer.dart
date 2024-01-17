import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tamred_app/messages/messages.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../BottomNav/video_controller.dart';
import '../CustomWidgets/VideoPlayerBottomSheet.dart';
import '../CustomWidgets/addCollection.dart';
import '../CustomWidgets/StackImages.dart';
import '../CustomWidgets/shareBottomSheet.dart';
import '../Mapbox/MapBoxGlobe.dart';
import '../messages/messageSection.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final TextEditingController _collectionController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  late PageController _pageController;
  late VideoPlayerController _controller;
  late bool _isPlaying = false;
  late bool _liked = false;
  late bool _showItem = false;
  late bool isVisible = false;
  Map<int, bool> heartColors = {};
  List<bool> _likedStatus = [];

  int _currentPage = 0;
  List<String> videoAssets = [
    'assets/videos/lake.mp4',
    'assets/videos/lake.mp4',
    'assets/videos/lake.mp4',
  ];
  List<String> Countries = [
    'Canada',
    'Japan',
    'USA',
    'India',
    'Canada',
  ];
  List<String> comments = [];

  void addComment(String newComment) {
    setState(() {
      comments.add(newComment);
    });
  }

  void postComment() {
    if (_commentController.text.isNotEmpty) {
      addComment(_commentController.text);
      _commentController.clear();
      print(comments);
    }
  }

  @override
  void initState() {
    super.initState();
    _likedStatus = List.filled(videoAssets.length, false);
    _pageController = PageController(initialPage: 0);
    _controller = VideoPlayerController.asset(videoAssets[0])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          if (_controller.value.isPlaying && mounted) {
            setState(() {
              _isPlaying = true;
            });
          } else {
            setState(() {
              _isPlaying = false;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }



  void _toggleLike(int index) {
    setState(() {
      _likedStatus[index] = !_likedStatus[index];
    });
  }

  void _toggleMap(){
    setState(() {
      isVisible = !isVisible;
      _controller.pause();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Video player\
          Visibility(
            visible: !isVisible,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                controller: _pageController,
                itemCount: videoAssets.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                    _controller = VideoPlayerController.asset(videoAssets[index])
                      ..initialize().then((_) {
                        setState(() {});
                        _controller.play();
                      });
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: _toggleVideoPlayback,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: MediaQuery.of(context).size.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
              child: MapBoxGlobe()),

          Visibility(
            visible: !isVisible,
            child: Positioned(
              left: 160.0,
              right: 0.0,
              top: 90.0,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect: ScaleEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withOpacity(0.6),
                  dotWidth: 5.0,
                  dotHeight: 5.0,
                  spacing: 7.0,
                ), // Change effect as needed
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Positioned(
              left: 140.0,
              right: 0.0,
              top: 80.0,
              child: Text(
                'back to media',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MuseoModerno',
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 4,




                  // You can also specify other styles such as color, font size, etc.
                ),
              ),
            ),
          ),
          // Pause image in the center (only when paused)
          Visibility(
            visible: !_isPlaying && !isVisible,
            child: Center(
              child: GestureDetector(
                onTap: _toggleVideoPlayback,
                child: Container(
                  child: SvgPicture.asset(
                    'assets/images/pause.svg',
                    width: MediaQuery.of(context).size.width *
                        0.18, // Adjust width as needed
                  ),
                ),
              ),
            ),
          ),
          // Positioned LinearProgressIndicator at the top (only when paused)
          if (!_isPlaying)
            Visibility(
              visible: !isVisible,
              child: Positioned(
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                top: MediaQuery.of(context).size.height * 0.82,
                child: LinearProgressIndicator(
                  minHeight: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  value: _controller.value.duration.inMilliseconds > 0
                      ? _controller.value.position.inMilliseconds /
                          _controller.value.duration.inMilliseconds
                      : 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),

          Visibility(
            visible: !_showItem,
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: isVisible ? Color(0xffFFCD240): Colors.white.withOpacity(0.3),
                          ),
                          child: GestureDetector(
                              onTap: (){
                                _toggleMap();
                              },
                              child: SvgPicture.asset('assets/images/globe.svg',
                              ))),
                      Spacer(),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(36)),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                    'assets/images/profilePic.svg'),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              Container(
                                height: 18,
                                width: 1,
                                color: Colors.black,
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

                                  child: Image.asset('assets/images/messages.png'))
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !isVisible,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Moraine Lake',
                              style: TextStyle(
                                  fontFamily: 'MuseoModerno',
                                  fontSize: MediaQuery.of(context).size.width * 0.08,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.grey.withOpacity(
                                          1), // Adjust shadow color and opacity
                                      blurRadius: 4, // Adjust the blur radius as needed
                                      offset: Offset(
                                          2, 2), // Adjust the offset of the shadow
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/canadaFlag.png',
                              height: MediaQuery.of(context).size.height * 0.024,
                            ),
                            SizedBox(
                                width: 5), // Add some spacing between the flag and text
                            Text(
                              'Alberta, Canada',
                              style: TextStyle(
                                fontFamily: 'MuseoModerno',
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey.withOpacity(1),
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.48,
              left: MediaQuery.of(context).size.width * 0.8,
              right: MediaQuery.of(context).size.width * 0,
              child: Column(
                children: [
                  GestureDetector(
                    child: SvgPicture.asset('assets/images/Save.svg'),
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.45,
                          // Set the height as needed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Color(0xff4A4A4A),
                                height: MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        width: MediaQuery.of(context).size.width *
                                            0.2,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC2C2C2), // Your color
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/ContentBlock.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.065,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.16,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'All favourites',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '500 spots',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          SvgPicture.asset(
                                            'assets/images/Save.svg',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.04,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.04,
                                            color: Color(0xffF8CF40),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Color(0xff4A4A4A).withOpacity(0.85),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Albums',
                                                style: TextStyle(
                                                  fontFamily: 'MuseoModerno',
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.015,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  setState(() {
                                                    _showItem = !_showItem; // Toggling _showItem
                                                  });
                                                  if (_showItem) {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(context).size.width * 0.1,
                                                                  vertical: MediaQuery.of(context).size.height * 0.03,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      child: Container(
                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                        width: MediaQuery.of(context).size.height * 0.09,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.transparent,
                                                                          border: Border.all(color: Colors.white),
                                                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                                                        ),
                                                                        child: Center(
                                                                          child: Material(
                                                                            child: Text('cancel',style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: 'MuseoModerno',
                                                                              fontSize: MediaQuery.of(context).size.height * 0.013
                                                                            ),),
                                                                            color: Colors.transparent,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onTap: (){
                                                                        Get.back();
                                                                        setState(() {
                                                                          _showItem = false; // Set _showItem to true when the dialog is closed
                                                                        });
                                                                      },
                                                                    ),
                                                                    Spacer(),
                                                                    GestureDetector(
                                                                      child: Container(
                                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                                        width: MediaQuery.of(context).size.height * 0.09,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xffF8CF40),
                                                                          border: Border.all(color: Color(0xffF8CF40)),
                                                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                                                        ),
                                                                        child: Center(
                                                                          child: Material(
                                                                            child: Text('Save',style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontFamily: 'MuseoModerno',
                                                                              fontSize: MediaQuery.of(context).size.height * 0.013
                                                                            ),),
                                                                            color: Color(0xffF8CF40),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onTap: (){
                                                                          setState(() {
                                                                            // Add the entered city to the Countries list
                                                                            Countries.add(_collectionController.text);
                                                                            // Reset the text field
                                                                            _collectionController.clear();
                                                                            // Close the dialog
                                                                            setState(() {
                                                                              _showItem = false; // Set _showItem to true when the dialog is closed

                                                                            });
                                                                            Get.back();
                                                                            print(Countries);
                                                                          });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                                              Dialog(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(50.0),
                                                                ),
                                                                backgroundColor: Colors.transparent,
                                                                child: AddCollection(collectionName: _collectionController),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    // Code to handle when the dialog is closed
                                                    setState(() {
                                                      _showItem = false; // Set _showItem to true when the dialog is closed
                                                    });
                                                  }
                                                },
                                                child: GestureDetector(
                                                  child: Text(
                                                    'New Album',
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoModerno',
                                                      fontSize: MediaQuery.of(context).size.height * 0.015,
                                                      color: Color(0xffF8CF40),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 3,),
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.22,
                                          child: Expanded(
                                            child: ListView.builder(
                                              itemCount: Countries.length,
                                              itemBuilder: (context, index) {
                                                // Replace this with the widget you want to display in the list
                                                return CustomButtonSheet(
                                                  image:
                                                      'assets/images/ContentBlock.png',
                                                  subtitle: '240 Spots',
                                                  title: Countries[index],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Add other widgets for your bottom sheet content
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    '2M',
                    style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(
                                1), // Adjust shadow color and opacity
                            blurRadius: 4, // Adjust the blur radius as needed
                            offset:
                                Offset(2, 2), // Adjust the offset of the shadow
                          ),
                        ]),
                  ),
                  GestureDetector(
                    onTap: () => _toggleLike(_currentPage),
                    child: SvgPicture.asset(
                      'assets/images/Like.svg',
                      color: _likedStatus[_currentPage] ? Colors.red : null,
                    ),
                  ),
                  Text(
                    '1,2k',
                    style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(
                                1), // Adjust shadow color and opacity
                            blurRadius: 4, // Adjust the blur radius as needed
                            offset:
                                Offset(2, 2), // Adjust the offset of the shadow
                          ),
                        ]),
                  ),
                  GestureDetector(
                      onTap: (){
                        Get.bottomSheet(
                          StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                            return SingleChildScrollView(
                              child: Container(
                                color: Color(0xff4A4A4A).withOpacity(0.8),
                                height: MediaQuery.of(context).size.height * 0.48,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Color(0xff4A4A4A),
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.009,),
                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.003,
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            color: Colors.white60,
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.024,),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20,),
                                            child: Row(
                                              children: [
                                                StackImages(),
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.26,),
                                                      child: Text(
                                                        'Liked by',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: MediaQuery.of(context).size.width * 0.03,
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Sean, John, ',
                                                          style: TextStyle(
                                                            fontFamily: 'Roboto',
                                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'and 120 others',
                                                          style: TextStyle(
                                                            fontFamily: 'Roboto',
                                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                                            color: Color(0xff9797BD),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: comments.length, // Replace with your desired item count
                                        itemBuilder: (BuildContext context, int index) {
                                          // Dummy data for illustration
                                          String title = 'Petter Siddle $index';
                                          String subtitle = 'I remember that $index';
                                          if (!heartColors.containsKey(index)) {
                                            heartColors[index] = false; // Default color
                                          }
                                          return ListTile(
                                            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                                            tileColor: Color(0xff4A4A4A).withOpacity(0.9),
                                            textColor: Colors.white,
                                            leading: CircleAvatar(
                                              // Replace with your image
                                              backgroundImage: NetworkImage(
                                                "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                                              ),
                                            ),
                                            title: Row(
                                              children: [
                                                Text(title),
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                                Text(
                                                  '10 min ago  reply',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff9797BD),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(comments[index]),
                                            trailing: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  heartColors[index] = !heartColors[index]!; // Toggle heart color for the specific tile
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                'assets/images/heatrtvector.svg',
                                                color: heartColors[index]! ? Colors.red : Colors.white,
                                                width: MediaQuery.of(context).size.width *
                                                    0.05, // Adjust width as needed
                                              ),
                                            )
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20, bottom: 10,right: 30, left: 25),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                            NetworkImage("https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"), // Replace with your image URL
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(30),
                                                border: Border.all(color: Colors.grey),
                                              ),
                                              child: TextFormField(
                                                controller: _commentController,
                                                style: TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                  hintText: 'Write your comment',
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                                  suffix: GestureDetector(
                                                      onTap: postComment,
                                                      child: Text('Post',style: TextStyle(color: Color(0xffF8CF40)),)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        }
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/Message.svg')
                  ),
                  Text(
                    '100',
                    style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(
                                1), // Adjust shadow color and opacity
                            blurRadius: 4, // Adjust the blur radius as needed
                            offset:
                                Offset(2, 2), // Adjust the offset of the shadow
                          ),
                        ]),
                  ),
                  GestureDetector(
                      onTap: (){
                        Get.bottomSheet(
                          ShareBottomSheet(),
                          isDismissible: true,
                          enableDrag: true,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        );
                      },
                      child: SvgPicture.asset('assets/images/share.svg')
                  ),
                  Text(
                    '200',
                    style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(
                                1), // Adjust shadow color and opacity
                            blurRadius: 4, // Adjust the blur radius as needed
                            offset:
                                Offset(2, 2), // Adjust the offset of the shadow
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}






