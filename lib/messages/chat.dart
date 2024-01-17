import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String image;

  ChatScreen({required this.name, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool isRecording = false;
  bool isplaying = false;
  bool isTextempty = false;

  List<Map<String, dynamic>> teamname = [
    {'status': 'Active Today'},
    {
      'image': 'assets/images/cycle.png',
      'text': 'Outdoor Cy...',
      'time': '24 min',
      'image2': 'assets/images/fire.png',
      'calories': '1282kcal'
    }
  ];

  // void requestGalleryPermission() async {
  //   var status = await Permission.storage.request();
  //   if (status == PermissionStatus.granted) {
  //     _openGallery();
  //   } else {
  //     print('Gallery permission denied');
  //   }
  // }

  void _openCamera() async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _handleImage(pickedFile.path);
      }
    } else {
      print('Camera permission denied');
    }
  }

  void _handleImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      ChatMessage message = ChatMessage(
        text: 'Image',
        isUser: true,
        isImage: true,
        imagePath: imagePath,
      );

      setState(() {
        _messages.add(message);
      });

      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
  late PickedFile? _pickedFile;

  Future<void> _openGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      bool userConfirmed = await _showImageConfirmationBottomSheet(pickedFile.path);

      if (userConfirmed) {
        _handleImage(pickedFile.path);
      }
    }
  }

  Future<bool> _showImageConfirmationBottomSheet(String imagePath) async {
    return await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color:const Color.fromRGBO(34,34,34,1),
          padding:const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(imagePath),
                  width: 350,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
             const  SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // User doesn't want to send the image
                    },
                    child:
                    const Text("Cancel",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Museo',
                      color: Color.fromRGBO(34,34,34,1)
                    ),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // User wants to send the image
                    },
                    child:
                    const Text("Send",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Museo',
                          color: Color.fromRGBO(34,34,34,1)
                      ),),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    ) ?? false; // Default to false if user cancels the bottom sheet
  }
  void handleimage(String imagePath){
    if(imagePath.isNotEmpty){
      ChatMessage message= ChatMessage(
        text: 'Image',
        isUser:  true,
        isImage:  true,
        imagePath: imagePath,
      );
      setState(() {
        _messages.add(message);
      });
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        isUser: true,
      );
      setState(() {
        _messages.add(message);
      });

      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      child: Image.asset('assets/images/arrow.png'),
                    ),
                  ),
                 const  SizedBox(
                    width: 15,
                  ),
                   Container(
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const  SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'sora')),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(teamname[0]['status'],
                                style: const TextStyle(
                                    color: Color.fromRGBO(127, 127, 127, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'sora'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (_, int index) => _messages[index],
              ),
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(34, 34, 34, 1)),
              child: _buildTextComposer(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width / 1,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: _textController,
              maxLines: null,
              onChanged: (text) {
                isTextempty = text.isNotEmpty;
              },
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: _openCamera,
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(248, 207, 64, 1),
                    child: Icon(CupertinoIcons.camera),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                hintText: 'Message',
                hintStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(151, 151, 189, 1)),
                filled: true,
                fillColor: const Color.fromRGBO(0, 0, 0, 0.5),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                suffixIcon: isTextempty
                    ? GestureDetector(
                        onTap: () {
                          _handleSubmitted(_textController.text);
                        },
                        child: const  Icon(Icons.send, color: Colors.white, size: 25),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _openGallery,
                            child: SvgPicture.asset(
                              'assets/images/image.svg',
                              height: 20,
                            ),
                          ),
                         const  SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child:  const Icon(CupertinoIcons.mic,
                                color: Colors.white, size: 25),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isImage;
  final String? imagePath;

  ChatMessage({
    required this.text,
    this.isUser = false,
    this.isImage = false,
    this.imagePath,
  });

  void openfullscreenimage(BuildContext
       context){
    if(isImage&& imagePath!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreenImage(imagePath:imagePath!)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Image.asset('assets/images/face2.png'),
              ),
            ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color.fromRGBO(67, 162, 250, 1)
                    : const Color.fromRGBO(23, 28, 47, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUser ? 16.0 : 0.0),
                  topRight: Radius.circular(isUser ? 16.0 : 16.0),
                  bottomLeft: const Radius.circular(16.0),
                  bottomRight: const Radius.circular(.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (!isUser)
                    Text(
                      'User',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  if (isImage)
                    GestureDetector(
                      onTap: ()=> openfullscreenimage(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(imagePath!),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (!isImage)
                    Wrap(
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget{
  final String imagePath;
  FullScreenImage({required this.imagePath});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: Get.height*1,
        child: Image.file(File(imagePath), fit: BoxFit.cover,),
      ),
    );
  }
}
