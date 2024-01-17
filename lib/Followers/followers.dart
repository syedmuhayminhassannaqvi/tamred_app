import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../messages/chat.dart';


class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  // List<Map<String, dynamic>> messages = [
  //   {'Image': 'assets/images/nasty.png', 'name': 'Jessica Smith', 'time': '2 m ago', 'new': '2', 'text': 'Thanks i really appreciated it'},
  //   {'Image': 'assets/images/smith.png', 'name': 'Joke Pratt', 'time': '30 m ago', 'new': '2', 'text': 'i truly am not impressed by your design'},
  //   {'Image': 'assets/images/denim.png', 'name': 'Brain Robson', 'time': '42 m ago', 'text': 'Lets keep creating amazing things'},
  //   {'Image': 'assets/images/jane.png', 'name': 'Julia Linwood', 'time': '1 h ago', 'text': 'Hello'},
  //   {'Image': 'assets/images/profile.png', 'name': 'Anna Dayson', 'time': '3 d ago', 'text': 'I hope best for your journey and hope to...'},
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding:  EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width*0.86,
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
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20,),
            Row(children: [
              Text('Sort by', style:  TextStyle(
                fontFamily: 'MuseoModerno',
                color: Colors.white,
              ),),
              SizedBox(width: 5,),
              Text('Default', style:  TextStyle(
                fontFamily: 'MuseoModerno',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
              Spacer(),
              SvgPicture.asset('assets/images/arrow-swap.svg'),

            ],),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.zero,
              height:  MediaQuery.of(context).size.height*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('All follwers (125k)',style:  TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height:  MediaQuery.of(context).size.height*0.6,
                      child: ListView.builder(
                        itemCount: 16,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: ListTile(
                              titleTextStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width*0.03,
                              ),
                              subtitleTextStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width*0.03,
                              ),
                              contentPadding: EdgeInsets.zero, // Set contentPadding to zero
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child:  Image.asset(
                                  'assets/images/nasty.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text('Name Surname',style:  TextStyle(
                                    fontFamily: 'MuseoModerno',
                                    color: Colors.white,
                                  ),),
                                  SizedBox(width: 5,),

                                  Text('Follow',style:  TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xff27BDDE),
                                  ),),
                                ],
                              ),
                              subtitle: Text('@sisters',style:  TextStyle(
                                fontFamily: 'MuseoModerno',
                                color: Colors.white,
                              ),),
                              trailing: Container(
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xff5F5F5F)
                                ),
                                child:   Center(
                                  child: Text('Remove',style:  TextStyle(
                                    fontFamily: 'MuseoModerno',
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width*0.02,
                                  ),),
                                ),
                              ),

                            )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
