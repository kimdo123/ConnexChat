import 'dart:developer';

import 'package:connex_chat/controller/api.dart';
import 'package:connex_chat/utils/util.dart';
import 'package:connex_chat/screen//bottom_navi/chat.dart';
import 'package:connex_chat/screen/bottom_navi/home.dart';
import 'package:connex_chat/screen/bottom_navi/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 변수 -------------------
  int _selectedIdx = 0;

  List<Widget> get _page => [
    Home(),
    Chat(),
    Profile(),
  ];

  // 화면 -------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIdx,
        children: _page,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.4),
                blurRadius: 5,
                offset: Offset(0, 1)
              ),
            ],
            borderRadius: BorderRadius.circular(100)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _selectedIdx,
              onTap: (index) {
                setState(() {
                  _selectedIdx = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Utils.svg('home_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svg('home_fill', 25, Colors.deepPurple),
                ),
                BottomNavigationBarItem(
                  label: 'Chat',
                  icon: Utils.svg('chat_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svg('chat_fill', 25, Colors.deepPurple),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Utils.svg('person_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svg('person_fill', 25, Colors.deepPurple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
