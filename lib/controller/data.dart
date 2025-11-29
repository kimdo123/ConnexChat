import 'package:connex_chat/model/m_dmp_list.dart';
import 'package:connex_chat/screen/bottom_navi/chat.dart';
import 'package:flutter/material.dart';

class Data {
  static List<EmpListModel> empList = [];
  static List<Widget> bookmarkChatList = [
  ];
  static List<Widget> allChatList = [
    ChatRoomWidget(),
    ChatRoomWidget(),
    ChatRoomWidget(),
    ChatRoomWidget(),
  ];
  static List<Widget> developmentChatList = [
    ChatRoomWidget(),
    ChatRoomWidget(),
    ChatRoomWidget(),
  ];

  static int chatInt = 0;
}
