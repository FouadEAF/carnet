 // ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carnet/screens/home.dart';
import 'package:carnet/screens/listProduct.dart';
import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/img/EAFLogo.jpg',
        splashIconSize: 400,
        duration: 1000,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(),
      ),

      routes: {
        'Home' : (context)=> HomePage(),
        'Products' : (context)=> ListProduct('nameList',0,true),

      },
    ));
}
