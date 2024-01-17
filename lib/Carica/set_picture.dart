import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../CustomWidgets/my_text_field.dart';

class SetPicture extends StatefulWidget {
  final String cover;
  const SetPicture({super.key,required this.cover});

  @override
  State<SetPicture> createState() => _SetPictureState();
}

class _SetPictureState extends State<SetPicture> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isCover = false;
  late ImagePicker _imagePicker;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF222222),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  'assets/images/arrow-circle-left_upload.svg')),
                          const Text(
                            "Upload a media",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.to( SetPicture());
                            },
                            child: const Text(
                              "Share",
                              style: TextStyle(
                                color: Color(0xFFF8CF40),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Color(0xFF161616),
                      ),
                      SizedBox(
                        height: 180,
                        child: Row(
                          children: [
                            // First Column (30%)
                            Expanded(
                              flex: 3,
                              child:  widget.cover.isNotEmpty
                                  ? Stack(
                                      children: [
                                        _pickedImage != null
                                            ? Image.file(
                                                _pickedImage!,
                                                height: double.infinity,
                                              )
                                            : Image.file(
                                         File(widget.cover),
                                          height: double.infinity,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          left: 0,
                                          right: 18,
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: _pickImage,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF012E40),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                                child: const Text(
                                                  'set cover',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          isCover = true;
                                          _pickImage();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF012E40),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: const Text(
                                            'set cover',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            // Second Column (70%)
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Text Input Field
                                  TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      border: OutlineInputBorder(),
                                      hintStyle:
                                          TextStyle(color: Color(0xFF565656)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 5),
                                      hintText:
                                          'Create more informative content with a maximum of 500 characters',
                                    ),
                                  ),
                                  const Spacer(),
                                  // Container with Hashtags
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 20),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF111111),
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: const Text(
                                          '#Hashtag',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF111111),
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: const Text(
                                          '@Mention',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xFF161616),
                      ),
                      const SizedBox(height: 10),
                      const MyTextFormField(
                          label: 'Title',
                          hint: 'Suggested Title: Morocco Desert'),
                      const MyTextFormField(
                        label: 'Location*',
                        hint: 'Morocco, Merzouga Desert',
                        suffixIcon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Color(0xFFBABABA),
                        ),
                      ),
                      const MyTextFormField(
                        label: 'Choose some filter*',
                        hint: 'Nature, Desert, Activity',
                        suffixIcon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Color(0xFFBABABA),
                        ),
                      ),
                      const Divider(
                        color: Color(0xFF161616),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: const Color(0xFF111111),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: ListTile(
                            leading: SvgPicture.asset('assets/images/comment.svg'),
                            title: const Text(
                              'Allow Comments',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: isSwitched1,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched1 = value;
                                  });
                                },
                              ),
                            )),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: const Color(0xFF111111),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: ListTile(
                            leading:
                                SvgPicture.asset('assets/images/money-send.svg'),
                            title: const Text(
                              'Promote Post',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: isSwitched2,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched2 = value;
                                  });
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
