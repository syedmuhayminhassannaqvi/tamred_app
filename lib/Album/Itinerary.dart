import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class CreateItinerary extends StatefulWidget {
  const CreateItinerary({Key? key}) : super(key: key);

  @override
  State<CreateItinerary> createState() => _CreateItineraryState();
}

class _CreateItineraryState extends State<CreateItinerary> {
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

  bool isItemSelected = false; // Initialize the flag

  void toggleSelection(int index) {
    setState(() {
      // Toggle selection
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }

      // Update the flag based on whether any item is selected
      isItemSelected = selectedIndices.isNotEmpty;
    });
  }




  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> evenIndexThumbnails = getEvenIndexThumbnails(thumbnails);
    List<Map<String, dynamic>> oddIndexThumbnails = getOddIndexThumbnails(thumbnails);
    return  SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the BoxFit as needed
          ),
        ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.2,
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
                        },
                      ),
                    ],
                  ),
                ),
                Text('Create the itinerary',style: TextStyle(
                  fontFamily: 'MuseoModerno',
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.white,
                ),),
                Text('Select places you want to include in itinerary',style: TextStyle(
                  fontFamily: 'MuseoModerno',
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis
                ),),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height ,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _controller1,
                              itemCount: evenIndexThumbnails.length,
                              itemBuilder: (context, index) {
                                bool isSelected = selectedIndices.contains(index);
                                return GestureDetector(
                                  onTap: (){
                                    toggleSelection(index); // Toggle selection on tap

                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adjust spacing as needed
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color:
                                            isSelected?
                                            Colors.yellow:Colors.transparent,
                                                width: 1.3),
                                          ),
                                          child: Image.asset(evenIndexThumbnails[index]['image']),
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
                                          right: 12,
                                          top: 10,
                                          child: SvgPicture.asset(
                                            isSelected?
                                            'assets/images/white-circle.svg':
                                            'assets/images/yellow-tick-circle.svg',
                                            width: 20,
                                            height: 20,
                                            color: isSelected? Colors.yellow:Colors.white,
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
                                                  Image.asset('assets/images/location.png',color: Colors.white,width: 12,),
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
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: _controller2,
                              itemCount: oddIndexThumbnails.length,
                              itemBuilder: (context, index) {
                                int adjustedIndex = index + evenIndexThumbnails.length;
                                bool isSelected = selectedIndices.contains(adjustedIndex);
                                return GestureDetector(
                                  onTap: (){
                                    toggleSelection(adjustedIndex); // Toggle selection on tap
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adjust spacing as needed
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color:  isSelected?
                                            Colors.yellow:Colors.transparent, width: 1.3),
                                          ),
                                          child: Image.asset(oddIndexThumbnails[index]['image']),
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
                                              ),

                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 12,
                                          top: 10,
                                          child: SvgPicture.asset(
                                            isSelected?
                                            'assets/images/white-circle.svg':
                                            'assets/images/yellow-tick-circle.svg',
                                            width: 20,
                                            height: 20,
                                            color: isSelected? Colors.yellow:Colors.white,
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
                                                  Image.asset('assets/images/location.png',color: Colors.white,width: 12,),
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
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.9,left: 10,right: 10
                      ),
                      child: GestureDetector(
                        onTap: () async {
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: isItemSelected ? Color(0xffFCD240) : Color(0xffFCD240).withOpacity(0.7) ,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
