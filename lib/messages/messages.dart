import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<Map<String, dynamic>> messages = [
    {'Image': 'assets/images/nasty.png', 'name': 'Jessica Smith', 'time': '2 m ago', 'new': '2', 'text': 'Thanks i really appreciated it'},
    {'Image': 'assets/images/smith.png', 'name': 'Joke Pratt', 'time': '30 m ago', 'new': '2', 'text': 'i truly am not impressed by your design'},
    {'Image': 'assets/images/denim.png', 'name': 'Brain Robson', 'time': '42 m ago', 'text': 'Lets keep creating amazing things'},
    {'Image': 'assets/images/jane.png', 'name': 'Julia Linwood', 'time': '1 h ago', 'text': 'Hello'},
    {'Image': 'assets/images/profile.png', 'name': 'Anna Dayson', 'time': '3 d ago', 'text': 'I hope best for your journey and hope to...'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 34, 34, 1),
      body: Padding(
        padding:  EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(61),
                    color:  Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  child: TextField(
                    // onChanged: filterMessages,
                    style:  TextStyle(
                      fontFamily: 'MuseoModerno',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon:  Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(61)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(61)),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'MuseoModerno',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
                  radius: 25,
                  child: Image.asset(
                    'assets/images/edit.png',
                    height: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: messages.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ChatScreen(
                      name: messages[index]['name'],
                      image: messages[index]['Image'],
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Stack(
                                    children:[ Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Image.asset(
                                       messages[index]['Image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                      if(index==4)
                                      Positioned(
                                          bottom: 1,
                                          right: -1,
                                          child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Color.fromRGBO(34,34,34,1),
                                        child: CircleAvatar(
                                          radius: 5,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset('assets/images/status.png', fit: BoxFit.cover,),
                                      ))
                                      )
                              ]
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                messages[index]['name'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'MuseoModerno',
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                           messages[index]['time'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'MuseoModerno',
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(184, 184, 184, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        messages[index]['text'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'MuseoModerno',
                                          fontWeight: FontWeight.w700,
                                          color: (index == 0 || index == 1)
                                              ? Color.fromRGBO(67, 162, 250, 1)
                                              : Color.fromRGBO(184, 184, 184, 1),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (index == 0 || index == 1)
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(67, 162, 250, 1),
                                ),
                                child: Center(
                                    child: Text(
                                      messages[index]['new'],
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: Get.width * 1,
                          color: Color.fromRGBO(184, 184, 184, 1),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
