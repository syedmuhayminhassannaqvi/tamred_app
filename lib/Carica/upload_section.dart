import 'package:flutter/material.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tamred_app/Carica/set_picture.dart';
import 'dart:io';
import 'dart:convert';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../models/file_model.dart';

class VideoPickerController extends GetxController {
  RxList<FileModel> videoFiles = <FileModel>[].obs;

  Rx<FileModel> selectedModel = FileModel(files: [], folderName: "").obs;

  RxList<int> selectedFiles = <int>[].obs;

  RxString selectedThumbnail = ''.obs;
}

class UploadMedia extends StatefulWidget {
  const UploadMedia({super.key});

  @override
  State<UploadMedia> createState() => _UploadMediaState();
}

class _UploadMediaState extends State<UploadMedia> {
  VideoPickerController controller = Get.put(VideoPickerController());
  late Future<List<FileModel>> vidPath;

  // late VideoPlayerController _videoaPlayerController;
  // late File _video;
  // final picker = ImagePicker();

  // _pickVideo() async {
  //   final video = await picker.pickVideo(source: ImageSource.gallery);
  //
  //   _video = File(video!.path);
  //   _videoaPlayerController = VideoPlayerController.file(_video)
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoaPlayerController.play();
  //     });
  // }

  @override
  void initState() {
    if (!Platform.isIOS) {
      vidPath = pickVideoPath();
    } else {
      vidPath = Future(() => <FileModel>[]);
    }
    // _pickVideo();

    super.initState();
  }

  Future<List<FileModel>> pickVideoPath() async {
    List paths = [];

    try {
      String? videoPath = await StoragePath.videoPath;
      paths = jsonDecode(videoPath ?? "[]") as List;
      debugPrint("this is vid $paths");
    } catch (e) {
      debugPrint("this is storage path error ${e.toString()}");
    }

    List<FileModel> videoFiles =
        paths.map<FileModel>((path) => FileModel.fromJson(path)).toList();

    return videoFiles;
  }

  List<DropdownMenuItem<FileModel>> getItems() {
    List<DropdownMenuItem<FileModel>> items = controller.videoFiles
        .map(
          (videoFile) => DropdownMenuItem(
            value: videoFile,
            child: Text(videoFile.folderName),
          ),
        )
        .toList();

    return items;
  }

  Future<String?> generateThumbnail(String path) async {
    debugPrint("path is $path");
    return VideoThumbnail.thumbnailFile(
      video: File(path).path,
      quality: 40,
      thumbnailPath: (await getTemporaryDirectory()).path,
    );
  }

  Widget buildThumbnailContainer(int index) {
    FileModel? selectedModel = controller.selectedModel.value;

    if (index < selectedModel.files.length) {
      // The index is within the valid range of files
      return Center(
        child: FutureBuilder(
          future: generateThumbnail(
            selectedModel.files[index].path,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  controller.selectedThumbnail.value = snapshot.data!;
                },
                child: Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(snapshot.data.toString())),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (controller.selectedFiles.contains(index))
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.yellow,
                          child: Center(
                            child: Text(
                              (controller.selectedFiles.indexOf(index) + 1)
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else {
              // Display a placeholder (skeleton) while the thumbnail is being generated
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[300], // Use your desired placeholder color
              );
            }
          },
        ),
      );
    } else {
      // The index is out of bounds
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<FileModel>>(
        future: vidPath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Material(
              child: Center(
                child: Text('Error loading video files'),
              ),
            );
          } else {
            controller.videoFiles.value = snapshot.data as List<FileModel>;

            if (controller.videoFiles.isNotEmpty) {
              controller.selectedModel.value = controller.videoFiles[0];
            } else {
              controller.selectedModel.value =
                  FileModel(files: [], folderName: "");
            }

            return Scaffold(
              backgroundColor: const Color(0xFF222222),
              body: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  child: SvgPicture.asset('assets/images/close.svg'),
                              onTap: (){
                                    Get.back();
                              },
                              ),
                              GestureDetector(
                                onTap: () {
                                  // _pickVideo();
                                },
                                child: const Text(
                                  "Upload a media",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(SetPicture(
                                    cover: controller.selectedThumbnail.value,
                                  ));
                                },
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Color(0xFFF8CF40),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Obx(
                                    () {
                                      if (controller.selectedThumbnail.value !=
                                          '') {
                                        return Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(File(controller
                                                  .selectedThumbnail.value)),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: Text(
                                          'Select Video',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  // Adjust the bottom position as needed
                                  left: 10,
                                  // Adjust the left position as needed
                                  child: SvgPicture.asset(
                                      'assets/images/maximize.svg'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Recents",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  "Photo Gallery",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  backgroundColor: const Color(0xFFF8CF40),
                                  radius: 18,
                                  child: SvgPicture.asset(
                                      'assets/images/gallery.svg'),
                                ),
                                const SizedBox(width: 10.0),
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF3d3d3d),
                                  radius: 18,
                                  child:
                                      SvgPicture.asset('assets/images/camera.svg'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                      child: Obx(
                        () => GridView.builder(
                            // key: UniqueKey(),
                            // physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                            ),
                            itemCount:
                                controller.selectedModel.value.files.length,
                            cacheExtent: controller
                                .selectedModel.value.files.length
                                .toDouble(),
                            itemBuilder: (context, index) =>
                                buildThumbnailContainer(index)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
