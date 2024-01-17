import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamred_app/Album/AlbumSearch.dart';

class SavedLocation extends StatefulWidget {
  const SavedLocation({super.key});

  @override
  State<SavedLocation> createState() => _SavedLocationState();
}

class _SavedLocationState extends State<SavedLocation> {
  List<Map<String, dynamic>> media = [
    {'media': '560 media'},
    {'media': '140 media'},
    {'media': '660 media'},
    {'media': '660 media'},
    {'media': '660 media'},
    {'media': '660 media'},
  ];
  List<Map<String, dynamic>> locations = [
    {
      'text': "All favourites",
      'location': 'Worldwide',
    },
    {
      'text': "Capodanna",
      'location': 'Denmark',
    },
    {
      'text': "Summer Trip",
      'location': 'Tokyo,Japan',
    },
    {
      'text': "Summer Trip",
      'location': 'Tokyo,Japan',
    }, {
      'text': "Summer Trip",
      'location': 'Tokyo,Japan',
    },
    {
      'text': "Summer Trip",
      'location': 'Tokyo,Japan',
    }


  ];
  List<Map<String, dynamic>> thumbnails = [
    {'image': 'assets/images/road.png'},
    {'image': 'assets/images/beljium.png'},
    {'image': 'assets/images/china.png'},
    {'image': 'assets/images/road.png'},
    {'image': 'assets/images/beljium.png'},
    {'image': 'assets/images/china.png'},
  ];

  int _calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1024) {
      return 4;
    } else if (screenWidth >= 450) {
      return 3;
    } else {
      return 2;
    }
  }

  double _ratio(BuildContext context) {
    double childAspectRatio;
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth == 360) {
      childAspectRatio = 5.5 / 9;
    } else {
      childAspectRatio = 6.5 / 9;
    }

    return childAspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 7, 54),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the BoxFit as needed
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 290,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20,),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    child: GridView.builder(
                        padding: EdgeInsets.all(0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 16,
                            crossAxisCount: _calculateCrossAxisCount(context),
                            childAspectRatio: _ratio(context)),
                        itemCount: thumbnails.length,
                        shrinkWrap: true,
                        itemBuilder: (Context, index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(AlbumSearch());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  color: Colors.black),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30)),
                                        height: 114,
                                        width: 134,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset(
                                            thumbnails[index]['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: Text(
                                        locations[index]['text'],
                                        style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'MuseoModerno'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/location.png',
                                            height: 20,
                                          ),
                                          Text(
                                            locations[index]['location'],
                                            style: const TextStyle(
                                                color:
                                                    Color.fromRGBO(191, 191, 191, 0.5),
                                                fontSize: 12,
                                                fontFamily: 'MuseoModerno'),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      height: 25,
                                      width: 69,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                              color:  Color.fromRGBO(
                                                  191, 191, 191, 1))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            media[index]['media'],
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'MuseoModerno',
                                                color: Color.fromRGBO(191, 191, 191, 1)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
