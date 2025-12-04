import 'package:connex_chat/views/chat/w_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core.dart';
import '../../app/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int channel = 0;
  bool? result = false;

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
                            fontSize: 24,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () async {
                            // await 해서 pop 할때 true false 값 받기
                            result = await showDialog(
                              context: context,
                              builder: (context) => DialogWidget(),
                            );
                            if (result ?? false) {
                              setState(() {
                                // 데이터 전체를 바꾸면 새로고침 해줌.
                                allChatList = List.from(allChatList);
                              });
                            }
                          },
                          child: Utils.svgFromAsset(
                            'chat_plus',
                            30,
                            Colors.white,
                          ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      channel = 0;
                                    });
                                  },
                                  child: Text(
                                    '즐겨찾기',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: channel == 0
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      channel = 1;
                                    });
                                  },
                                  child: Text(
                                    '사내 전체 공지',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: channel == 1
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      channel = 2;
                                    });
                                  },
                                  child: Text(
                                    '개발팀',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: channel == 2
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 500,
                              child: [
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      bookmarkChatList[index],
                                  itemCount: bookmarkChatList.length,
                                ),
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      allChatList[index],
                                  itemCount: allChatList.length,
                                ),
                                // TODO 삭제
                                ListView(children: developmentChatList),
                              ][channel],
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
}

class ChatRoomWidget extends StatelessWidget {
  final String? roomname;
  final VoidCallback isBookmark;

  const ChatRoomWidget({
    super.key,
    this.roomname,
    required this.isBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          // TODO API 채팅방
          log('채팅방 들어가기');
          Navigator.pushNamed(context, '/chatting_room');
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
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO API 채팅방 이름
                    Text(
                      roomname ?? '채팅방 이름',
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
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    isBookmark();
                    bookmarkChatList.add(allChatList[index]);
                    log('즐겨찾기');
                  },
                  child: Utils.svgFromAsset(
                    'bookmark_outline',
                    24,
                    Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
