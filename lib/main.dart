import 'package:connex_chat/screen/s_home.dart';
import 'package:connex_chat/screen/s_login.dart';
import 'package:connex_chat/screen/s_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'lex',
        scaffoldBackgroundColor: Colors.white,
      ),
    ),
  );
}
