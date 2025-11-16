import 'package:connex_chat/view/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'lex'),
    )
  );
}
