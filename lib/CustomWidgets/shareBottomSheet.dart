import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShareBottomSheet extends StatefulWidget {
  @override
  _ShareBottomSheetState createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  late List<String> items;
  late List<bool> isSelected;
  late List<String> filteredItems = [];

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    items = [
      'Khan',
      'Ahmad',
      'Naqvi',
      'Ali',
      'Muthar',
      'Qasim',
      'Muhaymin',
      'Hassan',
      'Zain',
      'Cheema',
      'Zain',
      'Cheema',
      'Zain',
      'Cheema',
    ];
    isSelected = List.generate(items.length, (index) => false);
    filteredItems = List.from(items);
  }

  void filterItems(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredItems = items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredItems = List.from(items);
      }
    });
  }

  bool isAnyTileSelected() {
    return isSelected.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    bool anyTileSelected = isAnyTileSelected();
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: Colors.black.withOpacity(0.6),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.003,
              width: MediaQuery.of(context).size.width * 0.15,
              color: Colors.white60,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            TextField(
              onChanged: filterItems,
              style: TextStyle(color: Colors.white), // Set the text color here
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'MuseoModerno',
                  color: Colors.white,
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon:
                    Icon(Icons.people_alt_outlined, color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  final originalIndex = items.indexOf(item);
                  return ListTile(
                    onTap: () {
                      setState(() {
                        isSelected[originalIndex] = !isSelected[originalIndex];
                      });
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                      ),
                    ),
                    title: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: SvgPicture.asset(
                      isSelected[originalIndex]
                          ? 'assets/images/bold.svg'
                          : 'assets/images/bluetick.svg',
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.16,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Divider(color: Colors.grey),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    !anyTileSelected
                        ? Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff5A5A5A),
                                    radius: 25,
                                    child: Icon(
                                      Icons.link,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    'Copy link',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff5A5A5A),
                                    radius: 25,
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff5A5A5A),
                                    radius: 25,
                                    child: Icon(
                                      Icons.downloading,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffFCD240),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                    fontFamily: 'MuseoModerno',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
