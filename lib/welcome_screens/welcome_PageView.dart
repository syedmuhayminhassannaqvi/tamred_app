import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamred_app/welcome_screens/welcomeOne.dart';
import 'package:tamred_app/welcome_screens/welcomeSecond.dart';
import 'package:tamred_app/welcome_screens/welcomeThird.dart';
import 'package:tamred_app/registration_Screen/login.dart'; // Assuming this is the correct import path for your Login Screen

class Welcome_PageView extends StatefulWidget {
  const Welcome_PageView({Key? key}) : super(key: key);

  @override
  State<Welcome_PageView> createState() => _Welcome_PageViewState();
}

class _Welcome_PageViewState extends State<Welcome_PageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    _pageController..addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    // Load adjacent pages when the current page changes
    setState(() {});
  }

  void _swipePage() {
    // Check if the current page is the last page
    if (_pageController.page == 2) {
      // Navigate to the Login Screen
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login_Screen()));
    } else {
      // Simulate swipe to the next page
      _pageController.nextPage(
        duration: Duration(milliseconds: 700),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [
                KeepAliveWrapper(child: WelcomeOne()),
                KeepAliveWrapper(child: WelcomeSecond()),
                KeepAliveWrapper(child: WelcomeThird()),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: _swipePage,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xffFCD240),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Wraps each page with AutomaticKeepAliveClientMixin
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure to call super.build(context)
    return widget.child;
  }
}
