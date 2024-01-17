import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tamred_app/profile/MapBoxViewTab.dart';
import 'package:tamred_app/profile/profile.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/NickName.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/createPassword.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/enterName.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/favourite_category.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/insert_email.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/let_explore.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/otpVerification.dart';
import 'package:tamred_app/registration_Screen/create_NewPassword.dart';
import 'package:tamred_app/registration_Screen/forget_Password.dart';
import 'package:tamred_app/registration_Screen/login.dart';
import 'package:tamred_app/videoplayer/videoPlayer.dart';
import 'package:tamred_app/welcome_screens/splash_screen.dart';
import 'package:tamred_app/welcome_screens/welcomeOne.dart';
import 'package:tamred_app/welcome_screens/welcomeSecond.dart';
import 'package:tamred_app/welcome_screens/welcomeThird.dart';
import 'package:tamred_app/welcome_screens/welcome_PageView.dart';
import 'Album/AlbumSearch.dart';
import 'Album/Itinerary.dart';
import 'Album/filterCategory.dart';
import 'BottomNav/video_controller.dart';
import 'Carica/upload_section.dart';
import 'CustomWidgets/StackImages.dart';
import 'CustomWidgets/addCollection.dart';
import 'CustomWidgets/filters.dart';
import 'CustomWidgets/moreTrends.dart';
import 'CustomWidgets/trendConatiner.dart';
import 'Explore/explore.dart';
import 'Explore/exploreSection.dart';
import 'Explore/trends.dart';
import 'Followers/followerSection.dart';
import 'Mapbox/MapBoxGlobe.dart';
import 'BottomNav/bottomNav.dart';
import 'demo.dart';
import 'registration_Screen/createNewAccount/googlemaps.dart';
import 'messages/messageSection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(GetMaterialApp(
    initialRoute: '/MapBoxGlobe',
    getPages: [
      GetPage(name: '/UploadMedia', page: () => UploadMedia()),
      GetPage(name: '/SplashScreen', page: () => SplashScreen()),
      GetPage(name: '/Favourite_place', page: () => FilterCategory()),
      GetPage(name: '/Trends', page: () => Trends()),
      GetPage(name: '/MoreTrends', page: () => MoreTrends()),
      GetPage(name: '/ExploreSection', page: () => ExploreSection()),
      GetPage(name: '/Explore', page: () => Explore()),
      GetPage(name: '/FollowersSection', page: () => FollowersSection()),
      GetPage(name: '/Favourite_place', page: () => Favourite_place()),
      GetPage(name: '/AlbumSearch', page: () => AlbumSearch()),
      GetPage(name: '/CreateItinerary', page: () => CreateItinerary()),
      GetPage(name: '/profile', page: () => profile()),
      GetPage(name: '/messageSection', page: () => MessageSection()),
      GetPage(name: '/MapBoxGlobe', page: () => MapBoxGlobe()),
      GetPage(name: '/GoogleMapScreen', page: () => GoogleMapScreen()),
      GetPage(name: '/StackImages', page: () => StackImages()),
      GetPage(name: '/GoogleMapScreen', page: () => GoogleMapScreen()),
      GetPage(name: '/VideoScreen', page: () => VideoScreen()),
      GetPage(name: '/Welcome_PageView', page: () => Welcome_PageView()),
      GetPage(name: '/WelcomeOne', page: () => WelcomeOne()),
      GetPage(name: '/WelcomeSecond', page: () => WelcomeSecond()),
      GetPage(name: '/WelcomeThird', page: () => WelcomeThird()),
      GetPage(name: '/Login_Screen', page: () => Login_Screen()),
      GetPage(name: '/Enter_Name', page: () => EnterName()),
      GetPage(name: '/Forget_Password', page: () => Forget_Password()),
      GetPage(name: '/AddCollection', page: () => AddCollection()),
      GetPage(name: '/BottomNavigator', page: () => BottomNavigator()),
      GetPage(
          name: '/OTPAndNewPasswordScreen',
          page: () => OTPAndNewPasswordScreen(
                email: '',
              )),
      GetPage(
          name: '/Insert_email',
          page: () => InsertEmail(
                firstName: '',
                lastName: '',
                username: '',
              )),
      GetPage(
          name: '/Create_Password',
          page: () => Create_Password(
                firstname: '',
                lastname: '',
                email: '',
                dateOfBirth: '',
                gender: '',
                username: '',
              )),
      GetPage(
          name: '/Nickname',
          page: () => Choose_Nickname(
                firstName: '',
                lastName: '',
                email: '',
                password: '',
                confirmPassword: '',
                username: '',
                gender: '',
                dateOfBirth: '',
              )),
      GetPage(
          name: '/OTP_Verification',
          page: () => OTP_Verification(
                email: '',
                token: '',
              )),
    ],
  ));
}
