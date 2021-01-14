import 'package:flutter/material.dart';
import 'package:myApp/constants.dart';
import 'Screens/Welcome/introSlide.dart';
import 'constants.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Sign',
      theme: ThemeData(
        fontFamily: 'Gilroy',
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
