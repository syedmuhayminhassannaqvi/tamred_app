import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCollection extends StatefulWidget {
  TextEditingController? collectionName;
   AddCollection({Key? key,this.collectionName}) : super(key: key);

  @override
  State<AddCollection> createState() => _AddCollectionState();
}

class _AddCollectionState extends State<AddCollection> {
  final _formKey = GlobalKey<FormState>();
  bool _allowFriendsToJoin = false;

  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xff222222),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Collection name',
                        style: TextStyle(
                          fontFamily: 'MuseoModerno',
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: widget.collectionName,
                    style: TextStyle(
                      fontFamily: 'MuseoModerno',
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter collection name',
                      hintStyle: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a collection name';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        'Collaborative',
                        style: TextStyle(
                          fontFamily: 'MuseoModerno',
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Allow friends to join this collection',
                        style: TextStyle(
                          fontFamily: 'MuseoModerno',
                          fontSize: MediaQuery.of(context).size.height * 0.01,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      Transform.scale(
                        scale: 0.8, // Adjust the scale as needed
                        child: Switch(
                          value: _allowFriendsToJoin,
                          onChanged: (value) {
                            setState(() {
                              _allowFriendsToJoin = value;
                            });
                          },
                          activeColor: Colors.white, // Color when active
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      )


                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
