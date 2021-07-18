import 'package:eatmore/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eat More',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: MaterialColor(0xffff0036, color),
      ),
      home: WelcomePage(),
    );
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(225, 0, 54, .1),
  100: Color.fromRGBO(225, 0, 54, .2),
  200: Color.fromRGBO(225, 0, 54, .3),
  300: Color.fromRGBO(225, 0, 54, .4),
  400: Color.fromRGBO(225, 0, 54, .5),
  500: Color.fromRGBO(225, 0, 54, .6),
  600: Color.fromRGBO(225, 0, 54, .7),
  700: Color.fromRGBO(225, 0, 54, .8),
  800: Color.fromRGBO(225, 0, 54, .9),
  900: Color.fromRGBO(225, 0, 54, 1),
};
