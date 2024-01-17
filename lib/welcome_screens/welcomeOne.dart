import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamred_app/welcome_screens/welcomeSecond.dart';

class WelcomeOne extends StatefulWidget {
  const WelcomeOne({Key? key}) : super(key: key);

  @override
  State<WelcomeOne> createState() => _WelcomeOneState();
}

class _WelcomeOneState extends State<WelcomeOne> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/WelcomeOneImage.png'),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tamred',style: TextStyle(
                    fontFamily: 'MuseoModerno',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*0.047
                  ),),
                  Icon(Icons.location_on_sharp,color: Colors.red,size: MediaQuery.of(context).size.width*0.05,)
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Row(
                children: [
                  Text("Let's explore the\nworld",style: TextStyle(
                      fontFamily: 'Urbanist',
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.11
                  ),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Row(
                children: [
                  Text("Let's explore there world with just\na few clicks",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.05
                  ),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.003,
                    width: MediaQuery.of(context).size.width*0.27,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.003,
                    width: MediaQuery.of(context).size.width*0.27,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.003,
                    width: MediaQuery.of(context).size.width*0.27,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.06,),
            ],
          ),
        ),
      ),
    );
  }
}
