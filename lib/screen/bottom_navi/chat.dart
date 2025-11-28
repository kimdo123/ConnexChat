import 'dart:developer';
import 'package:connex_chat/utils/util.dart';
import 'package:connex_chat/widget/w_popup.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool channel = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          '채팅방 목록',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => DialogWidget(),
                          ),
                          child: Utils.svg('chat_plus', 30, Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(30),
                        // padding: EdgeInsetsGeometry.fromLTRB(30, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      channel = !channel;
                                    });
                                  },
                                  child: Text(
                                    '사내 전체 공지',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: channel
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      channel = !channel;
                                    });
                                  },
                                  child: Text(
                                    '개발팀',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: channel
                                          ? Colors.black
                                          : Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 500,
                              child: channel
                                  ? ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            top: 10,
                                          ),
                                          child: chatingRoom(),
                                        );
                                      },
                                      // TODO API 채팅방 수
                                      itemCount: 5,
                                    )
                                  : ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            top: 10,
                                          ),
                                          child: chatingRoom(),
                                        );
                                      },
                                      // TODO API 채팅방 수
                                      itemCount: 2,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chatingRoom() {
    return GestureDetector(
      onTap: () {
        // TODO API 채팅방
        log('채팅방 들어가기');
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO API 채팅방 이름
                  Text(
                    '채팅방 이름',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // TODO API 채팅방 대화 목록
                  Text('채팅방 목록의 대화 내용입니다...'),
                ],
              ),
              Spacer(),
              // TODO API 시간
              Text('오후 10:21'),
            ],
          ),
        ),
      ),
    );
  }
}
