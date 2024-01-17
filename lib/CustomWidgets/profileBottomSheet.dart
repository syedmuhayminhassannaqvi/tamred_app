import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../Followers/followerSection.dart';
import '../videoplayer/videoPlayer.dart';

class ProfileBottomSheet extends StatefulWidget {
   ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {

  bool isSelectedCountry = false;
  bool isSelectedPin = false;
  bool isSelectedlikes = false;
  bool isSelectedComments = false;

  void toggleSelectedCountry(){
    setState(() {
      isSelectedCountry = !isSelectedCountry;
    });
  }
  void toggleSelectedPins(){
    setState(() {
      isSelectedPin = !isSelectedPin;
    });
  }
  void toggleSelectedlikes(){
    setState(() {
      isSelectedlikes = !isSelectedlikes;
    });
  }
  void toggleSelectedComments(){
    setState(() {
      isSelectedComments = !isSelectedComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
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
                            Text('Edit Profile',style: TextStyle(
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
                            Text('Share Profile',style: TextStyle(
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
                              'assets/images/friends.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),                                                SizedBox(width: 10,),
                            Text('Friend',style: TextStyle(
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
                      GestureDetector(
                        onTap: (){
                          Get.to(FollowersSection());
                        },
                        child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/followers.svg',
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),                                                SizedBox(width: 10,),
                              Text('Followers',style: TextStyle(
                                fontFamily: 'MuseoModerno',
                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                color: Colors.white,
                              ),),

                            ]
                        ),
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
                              'assets/images/location.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text('Show visited places',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
          
                          ]
                      ),
                      SizedBox(height: 6,),
                      Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/shareVideo.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text('Show total countries',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
                            Spacer(),
                            GestureDetector(
                              onTap: toggleSelectedCountry,
                              child: SvgPicture.asset(
                                isSelectedCountry
                                    ? 'assets/images/bold.svg'
                                    : 'assets/images/bluetick.svg',
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 6,),
                      Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/shareVideo.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text('Show total pins',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
                            Spacer(),
                            GestureDetector(
                              onTap: toggleSelectedPins,
                              child: SvgPicture.asset(
                                isSelectedPin
                                    ? 'assets/images/bold.svg'
                                    : 'assets/images/bluetick.svg',
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
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
                              'assets/images/media.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text('Media',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
          
                          ]
                      ),
                      SizedBox(height: 6,),
                      Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/shareVideo.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text('Show total likes',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
                            Spacer(),
                            GestureDetector(
                              onTap: toggleSelectedlikes,
                              child: SvgPicture.asset(
                                isSelectedlikes
                                    ? 'assets/images/bold.svg'
                                    : 'assets/images/bluetick.svg',
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 6,),
                      Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/shareVideo.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text('Allow comments',style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.white,
                            ),),
                            Spacer(),
                            GestureDetector(
                              onTap: toggleSelectedComments,
                              child: SvgPicture.asset(
                                isSelectedComments
                                    ? 'assets/images/bold.svg'
                                    : 'assets/images/bluetick.svg',
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
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
                              'assets/images/payments.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text('Payments',style: TextStyle(
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
                              'assets/images/helpSupport.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text('Help and Support',style: TextStyle(
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
                              'assets/images/setting-2.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),                                                SizedBox(width: 10,),
                            Text('Privacy and Settings',style: TextStyle(
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
                    ],
                  ),
                ), // Add other widgets for your bottom sheet content
              ],
            ),
          ),
        );
      },
    );

  }
}
