import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamred_app/Mapbox/MapBoxGlobe.dart';

import 'explore.dart';

class ExploreSection extends StatefulWidget {
  @override
  _ExploreSectionState createState() => _ExploreSectionState();
}

class _ExploreSectionState extends State<ExploreSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            // Content for each tab - initially hidden
            Positioned(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Explore(),
                  MapBoxGlobe(),
                  Center(child: Text('Near me Tab Content')),
                ],
              ),
            ),
            // Custom top bar with TabBar and search icon
            Positioned(
              top: 35,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Color(0xff353739),
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.5),
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                        color: Color(0xff27BDDE),
                      ),
                      labelColor: Colors.white,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.white,
                      indicatorWeight: 0.0,
                      tabs: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              _tabController.animateTo(0);
                              print(_tabController.index);
                            },
                            child: Tab(
                              text: 'Explore',
                            ),
                          ),
                          height: 20,
                          width: 120,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              _tabController.animateTo(1);
                              print(_tabController.index);
                            },
                            child: Tab(
                              text: 'Friend',
                            ),
                          ),
                          height: 20,
                          width: 120,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              _tabController.animateTo(2);
                            },
                            child: Tab(
                              text: 'Near me',
                            ),
                          ),
                          height: 20,
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xff353739),
                        shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset('assets/images/search-normal.svg',
                          height: 15),
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
}
