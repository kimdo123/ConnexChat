import '../models/dto_user.dart';
import '../views/chat/s_chat.dart';
import 'core.dart';

String token = '';
String username = '';

List<EmpListDTO> empList = [];

Map<String, bool> allChatRoomMap = {
  "공지방1": false,
  "공지방2": true,
  "공지방3": false,
};

// 전체 채팅방 (전체공지) 이름들
late List<String>allRooms;

List<Widget> developmentChatList = [];

int chatInt = 0;
