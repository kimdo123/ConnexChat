import 'package:connex_chat/view/login.dart';
import 'package:connex_chat/view/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'lex',
        scaffoldBackgroundColor: Colors.white,
      ),
    ),
  );
}
