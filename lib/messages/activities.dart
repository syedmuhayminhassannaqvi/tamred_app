import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  List<Map<String, dynamic>> newFollowers = [
    {'followers': '(2)'}
  ];
  List<Map<String, dynamic>> followers = [
    {
      'image': 'assets/images/profile.png',
      'name': 'Name Surname',
      'isFollowing': false
    },
    {
      'image': 'assets/images/profile.png',
      'name': 'Name Surname',
      'isFollowing': false
    },
  ];
  List<Map<String, dynamic>> today = [
    {
      'image': 'assets/images/denim.png',
      'name': 'Brain Robson',
      'time': '16m ago',
      'Image': 'assets/images/art.png'
    },
    {
      'image': 'assets/images/nasty.png',
      'name': 'Jessica Smith',
      'time': '10m ago',
      'Image': 'assets/images/vaper.png'
    },
  ];
  List<Map<String, dynamic>> suggested = [
    {
      'image': 'assets/images/profile.png',
      'name': 'Name Surname',
      'isFollowing': false
    },
    {
      'image': 'assets/images/profile.png',
      'name': 'Name Surname',
      'isFollowing': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'New Followers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Museo',
                ),
              ),
              Text(
                newFollowers[0]['followers'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Museo',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            itemCount: followers.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                followers[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  followers[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Museo',
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Started following you',
                                  style: TextStyle(
                                    color: Color.fromRGBO(185, 185, 185, 1),
                                    fontFamily: 'roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            followers[index]['isFollowing'] ? 100 : 115,
                            38,
                          ),
                          backgroundColor: followers[index]['isFollowing']
                              ? const Color.fromRGBO(84, 84, 84, 1)
                              : const Color.fromRGBO(39, 189, 222, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            followers[index]['isFollowing'] =
                                !followers[index]['isFollowing'];
                          });
                        },
                        child: Text(
                          followers[index]['isFollowing']
                              ? 'Following'
                              : 'Followback',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Museo',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 27,
          ),
          Row(
            children: [
              const Text(
                'Today',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Museo',
                    fontWeight: FontWeight.w700),
              ),
              Text(
                newFollowers[0]['followers'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Museo',
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 8,),
          ListView.builder(
            itemCount: today.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                today[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      today[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Museo',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const CircleAvatar(
                                      radius: 3,
                                      backgroundColor:
                                          Color.fromRGBO(51, 51, 51, 1),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      today[index]['time'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(185, 185, 185, 1),
                                        fontFamily: 'roboto',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'Liked your post',
                                  style: TextStyle(
                                    color: Color.fromRGBO(185, 185, 185, 1),
                                    fontFamily: 'roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          today[index]['Image'],
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 27,
          ),
          Row(
            children: [
              const Text(
                'Suggested accounts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Museo',
                ),
              ),
              Container(
                  height: 28,
                  child:Column(
    children: [
    Image.asset('assets/images/info.png', height: 15,)
    ],
    )
              )

            ],
          ),
          SizedBox(height: 10,),
          ListView.builder(
            itemCount: suggested.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    setState(() {
                      suggested.removeAt(index);
                    });
                  }

                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  suggested[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    suggested[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Museo',
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Started following you',
                                    style: TextStyle(
                                      color: Color.fromRGBO(185, 185, 185, 1),
                                      fontFamily: 'roboto',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    suggested[index]['isFollowing'] ?  105 :90,
                                    38,
                                  ),
                                  backgroundColor: suggested[index]['isFollowing']
                                      ? const Color.fromRGBO(84, 84, 84, 1)
                                      : const Color.fromRGBO(39, 189, 222, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    suggested[index]['isFollowing'] =
                                    !suggested[index]['isFollowing'];
                                  });
                                },
                                child: Text(
                                  suggested[index]['isFollowing']
                                      ? 'Following'
                                      : 'Follow',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Museo',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8,),
                              GestureDetector(
                                onTap:(){
                             setState(() {
                               suggested.removeAt(index);
                             });
              },
                                child: Icon(Icons.clear, size: 15,
                                  color: Color.fromRGBO(181,181,181,1),),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
