import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class VideoGrid extends StatefulWidget {
  const VideoGrid({super.key});

  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {

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
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              SizedBox(height: 280,),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
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
            ],
          ),
        ),
      ),

    );
  }
}
