import 'package:connex_chat/models/dto_user.dart';

import '../app/core.dart';

// TODO 이 토큰들 앱 시작할때 prefs로 받은거 token 에 저장해서 그냥 쓰기
// if(prefs.token =! null) {token = prefs.token} <= 이런 느낌?

class UserController {
  static Future<bool> login(
    TextEditingController email,
    TextEditingController password,
  ) async {
    final res = await post(
      Uri.parse('$API_URL/auth/login'),
      headers: API_HEADERS,
      body: jsonEncode({
        "email": email.text,
        "password": password.text,
      }),
    );
    if (jsonDecode(res.body)['success']) {
      log(jsonDecode(res.body).toString());
      token = jsonDecode(res.body)['data']['token'].toString();
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getUserinfo(String prefsToken) async {
    final headersWithToken = API_HEADERS;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$API_URL/users/me'),
      headers: headersWithToken,
    );
    log('정보 조회 : ${jsonDecode(res.body).toString()}');
    username = jsonDecode(res.body)['data']['name'];
  }

  static Future<void> getEmpList(prefsToken) async {
    final headersWithToken = API_HEADERS;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$API_URL/employees'),
      headers: headersWithToken,
    );
    log('getEmpList : ${jsonDecode(res.body).toString()}');

    empList = jsonDecode(
      res.body,
    )['data'].map<EmpListDTO>((e) => EmpListDTO.fromJson(e)).toList();
    log('최종 getEmpList : ${empList.toString()}');
  }

  static Future<void> getMessagesInt(prefsToken) async {
    final headersWithToken = API_HEADERS;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$API_URL/messages/unread'),
      headers: headersWithToken,
    );
    chatInt = jsonDecode(res.body)['data']['totalCount'];
  }

  static Future<bool> postCreatChat(
    String title,
    List<int> list,
    String prefsToken,
  ) async {
    final headersWithToken = API_HEADERS;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await post(
      Uri.parse('$API_URL/chatrooms/create'),
      headers: headersWithToken,
      body: jsonEncode({
        'roomName': title,
        'participants': list,
      }),
    );
    log('채팅방 생성 : ${jsonDecode(res.body).toString()}');
    if (jsonDecode(res.body)['success']) {
      return true;
    } else {
      return false;
    }
  }
}
