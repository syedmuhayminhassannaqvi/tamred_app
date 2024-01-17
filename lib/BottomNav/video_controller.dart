// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoController extends GetxController {
//   List<String> videoAssets = [
//     'assets/videos/lake.mp4',
//     'assets/videos/lake.mp4',
//     'assets/videos/lake.mp4',
//   ];
//   late final videoController = VideoPlayerController.asset(videoAssets as String); // Replace with placeholder asset
//   var currentIndex = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     videoController.initialize();
//   }
//
//   @override
//   void onClose() {
//     videoController.dispose();
//     super.onClose();
//   }
//
//   void handleTabChange(int index) {
//     currentIndex.value = index;
//     if (index != 0) { // Assuming VideoScreen is at index 0
//       videoController.pause();
//     }
//   }
//
//   void pauseVideo() {
//     videoController.pause();
//   }
// }
