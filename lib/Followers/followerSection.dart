import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../messages/activities.dart';
import '../messages/messages.dart';
import 'followers.dart';
import 'following.dart';


class FollowersSection extends StatefulWidget {
  const FollowersSection({Key? key}) : super(key: key);

  @override
  State<FollowersSection> createState() => _FollowersSectionState();
}

class _FollowersSectionState extends State<FollowersSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BorderRadius _borderRadiusSelectedTab = BorderRadius.circular(25.0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChange);

    // Set initial border radius value
    _borderRadiusSelectedTab =const BorderRadius.only(
      topLeft: Radius.circular(25.0),
      topRight: Radius.circular(0.0),
      bottomLeft: Radius.circular(25.0),
      bottomRight: Radius.circular(0.0),
    );
  }

  void _onTabChange() {
    setState(() {
      // Update the border radius for the selected tab
      _borderRadiusSelectedTab = _tabController.index == 0
          ?const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(0.0),
        bottomLeft: Radius.circular(25.0),
        bottomRight: Radius.circular(0.0),
      )
          :const BorderRadius.only(
        topLeft: Radius.circular(0.0),
        topRight: Radius.circular(25.0),
        bottomLeft: Radius.circular(0.0),
        bottomRight: Radius.circular(25.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BACKGROUNDIMAGE.png'), // Replace with your image path
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          ),
          child: Column(
            children: [
               SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0), // Unselected tabs
                    ),
                    height: 35,
                    width: Get.width * 0.65,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      indicator: BoxDecoration(
                        color: Color.fromRGBO(248, 207, 64, 1),
                        borderRadius: _borderRadiusSelectedTab, // Selected tab
                      ),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'MuseoModerno',
                            ),
                          ),
                        ),
                        Tab(
                          child:  Text(
                            'Following',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'MuseoModerno',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 21.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height:
                                // Get.width<=440?MediaQuery.of(context).size.height/1.3:
                                // Get.width<=420?MediaQuery.of(context).size.height/1.2:
                                MediaQuery.of(context).size.height/1,
                                child: Followers()),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 21.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Container(
                                height:
                                MediaQuery.of(context).size.height/1,
                                child: Following()),

                          ],
                        ),
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
