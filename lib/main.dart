import 'dart:developer';

import 'package:connex_chat/screen/s_home.dart';
import 'package:connex_chat/screen/s_login.dart';
import 'package:connex_chat/screen/s_splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 변수 ---------------------------------
  bool splashState = false;
  bool loginState = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    splashState = prefs.getBool('isSplashPassed') ?? false;
    loginState = prefs.getBool('isLoginPassed') ?? false;
    setState(() {});
  }

  // 화면 ---------------------------------
  @override
  Widget build(BuildContext context) {
    log(loginState.toString());
    return MaterialApp(
      key: ValueKey(DateTime.now().microsecond),
      initialRoute: splashState
          ? loginState
                ? '/home'
                : '/login'
          : '/',
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
    );
  }
}
