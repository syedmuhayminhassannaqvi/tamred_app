import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late List<bool> isSelected; // Declare isSelected list

  double _padding = 8;

  final List<MyObject> myObjects = [
    MyObject([
      {"path": 'assets/images/tree.png', "name": "Tree"},
    ]),
    MyObject([
      {"path": 'assets/images/tent.png', "name": "Tree"},
    ]),
    MyObject([
      {"path": 'assets/images/volcano.png', "name": "Hello"},
      {"path": 'assets/images/mountain.png', "name": "Hello"},
      {"path": 'assets/images/plant.png', "name": "Hello"},
      {"path": 'assets/images/plant.png', "name": "Hello"},
      {"path": 'assets/images/plant.png', "name": "Hello"},
      {"path": 'assets/images/tent.png', "name": "Hello"},
    ]),
    MyObject([
      {"path": 'assets/images/plant.png', "name": "Mountain"},
    ]),
    MyObject([
      {"path": 'assets/images/mountain.png', "name": "Mountain"},
    ]),
    MyObject([
      {"path": 'assets/images/tent.png', "name": "Mountain"},
    ]),
    MyObject([
      {"path": 'assets/images/mountain.png', "name": "Mountain"},
    ]),
    // Add more objects as needed
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = List.generate(myObjects.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(
          myObjects.length,
              (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
              child: Container(
                width: calculateContainerWidth(myObjects[index]),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: isSelected[index] ? Colors.yellow : Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 15,
                      top: 20,
                      child: Icon(
                        Icons.check_circle,

                        color: isSelected[index] ? Colors.yellow:Colors.transparent,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 7, vertical: 35),
                      child: Center(
                        child: Wrap(
                          spacing: size.width * 0.1,
                          alignment: WrapAlignment.center,
                          children:  myObjects[index].imagesList
                            .map(
                        (image) => Column(
                      children: [
                      Image.asset(
                      image["path"]!,
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        image["name"]!,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      ],
                    ),
              ).toList(), // Convert Iterable<Column> to List<Widget>

    // Remaining code...

            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateContainerHeight(MyObject myObject) {
    // Calculate the height based on the number of texts in the object
    return myObject.imagesList.length == 1 ? Get.height / 4 : Get.height / 3;
  }

  double calculateContainerWidth(MyObject myObject) {
    // Calculate the width based on the number of texts in the object
    return myObject.imagesList.length >= 2 ? Get.width : Get.width * 0.4;
  }
}

class MyObject {
  final List<Map<String, String>> imagesList;

  MyObject(this.imagesList);
}
