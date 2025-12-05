import 'package:connex_chat/views/chat/w_create_chat_dialog.dart';
import 'package:connex_chat/views/chat/w_edit_chat_dialog.dart';
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
    allRooms = allChatRoomMap.keys.toList();
    // 전체 중에 즐겨찾기 된거 찾기
    // .entries : Map에 (key,value) 하나씩 꺼내기
    // .where : (key,value) 받아서 value 가 true인지 확인
    // .map : true 면 key(방이름) 가져오기
    final bookMarkRooms = allChatRoomMap.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();
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
                    padding: EdgeInsets.all(20),
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
                            // await 해서 pop 할때 넘어오는 값 받기
                            String? result = await showDialog(
                              context: context,
                              builder: (context) => CreateChatDialogWidget(),
                            );
                            if (result != null) {
                              allChatRoomMap[result] = false;
                              setState(() {});
                            }
                            // TODO 채팅방 생성하기
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
                        padding: EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                _sectionTap(0, '즐겨찾기'),
                                _sectionTap(1, '사내 전체 공지'),
                                _sectionTap(2, '개발팀'),
                              ],
                            ),
                            SizedBox(
                              height: 500,
                              child: [
                                // 즐겨찾기 채팅 방
                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ChatRoomWidget(
                                      roomname: bookMarkRooms[index],
                                      isBookmarked: true,
                                      toggleBookmark: toggleBookmark,
                                    );
                                  },
                                  itemCount: bookMarkRooms.length,
                                ),

                                // 전체 채팅 방
                                ListView.builder(
                                  itemBuilder: (context, index) {
                                    final roomnameList = allRooms[index];
                                    return ChatRoomWidget(
                                      roomname: allRooms[index],
                                      isBookmarked:
                                          allChatRoomMap[roomnameList]!,
                                      toggleBookmark: toggleBookmark,
                                    );
                                  },
                                  itemCount: allRooms.length,
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

  Widget _sectionTap(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          channel = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: channel == index ? Colors.deepPurple : Colors.black,
        ),
      ),
    );
  }

  void toggleBookmark(String roomname) {
    allChatRoomMap[roomname] = !(allChatRoomMap[roomname]!);
    setState(() {});
  }
}

class ChatRoomWidget extends StatefulWidget {
  final String? roomname;
  final bool isBookmarked;
  final Function toggleBookmark;

  const ChatRoomWidget({
    super.key,
    this.roomname,
    required this.isBookmarked,
    required this.toggleBookmark,
  });

  @override
  State<ChatRoomWidget> createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        // 채팅방 수정
        onLongPress: () async {
          log('채팅방 수정');
          final bool? isEdited = await showDialog(
            context: context,
            builder: (context) => EditChatDialogWidget(
              roomname: widget.roomname ?? '채팅방 이름',
            ),
          );
          if (isEdited != null && isEdited) {
            allChatRoomMap.remove(widget.roomname);
            Navigator.pop(context);
          } else {
            log('채팅방이 삭제되지 않음');
          }
        },
        // 채팅방 들어가기
        onTap: () {
          // TODO API 채팅방 입장
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
                    Text(
                      widget.roomname ?? '채팅방 이름',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('채팅방 목록의 대화 내용입니다...'),
                  ],
                ),
                Spacer(),
                Text('오후 10:21'),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    log('즐겨찾기');
                    widget.toggleBookmark(widget.roomname);
                    setState(() {});
                  },
                  child: Utils.svgFromAsset(
                    widget.isBookmarked == true
                        ? 'bookmark_fill'
                        : 'bookmark_outline',
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
