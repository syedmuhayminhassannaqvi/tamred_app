

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class InstagramUploadScreen extends StatefulWidget {
  @override
  _InstagramUploadScreenState createState() => _InstagramUploadScreenState();
}

class _InstagramUploadScreenState extends State<InstagramUploadScreen> {
  List<XFile> images = [];
  XFile? video;
  VideoPlayerController? videoController;

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Upload'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display selected images
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) => Image.file(File(images[index].path)),
            ),
          ),
          // Display selected video
          if (video != null)
            AspectRatio(
              aspectRatio: videoController!.value.aspectRatio,
              child: VideoPlayer(videoController!),
            ),
          // Upload buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(),
                child: Icon(Icons.image),
              ),
              ElevatedButton(
                onPressed: () => _pickVideo(),
                child: Icon(Icons.videocam),
              ),
              ElevatedButton(
                onPressed: () => _upload(),
                child: Text('Upload'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to pick images from gallery
  _pickImage() async {
    final pickedImages = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {
      setState(() {
        images.add(pickedImages);
      });
    }
  }

// Function to pick video from gallery
  _pickVideo() async {
    final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        video = pickedVideo;
        videoController = VideoPlayerController.file(File(video!.path))
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  // Function to handle the upload logic
  _upload() {
    // Implement your upload logic here
  }
}
