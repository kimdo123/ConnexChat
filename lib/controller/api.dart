import 'dart:convert';
import 'dart:developer';
import 'package:connex_chat/controller/data.dart';
import 'package:connex_chat/model/m_dmp_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

final String baseUrl = 'http://arkenzo.dothome.co.kr/connexchat';
final headers = {'Content-type': 'application/json'};

late String token;
late String username;

class Auth {
  static Future<bool> login(
    TextEditingController email,
    TextEditingController password,
  ) async {
    final res = await post(
      Uri.parse('$baseUrl/auth/login'),
      headers: headers,
      body: jsonEncode({
        "email": email.text,
        "password": password.text,
      }),
    );
    log(jsonDecode(res.body).toString());
    token = jsonDecode(res.body)['data']['token'].toString();
    return jsonDecode(res.body)['success'];
  }

  static Future<void> getUserinfo(prefsToken) async {
    final headersWithToken = headers;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$baseUrl/users/me'),
      headers: headersWithToken,
    );
    log('정보 조회 : ${jsonDecode(res.body).toString()}');
    username = jsonDecode(res.body)['data']['name'];
  }

  static Future<void> getEmpList(prefsToken) async {
    final headersWithToken = headers;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$baseUrl/employees'),
      headers: headersWithToken,
    );
    log('getEmpList : ${jsonDecode(res.body).toString()}');

    Data.empList = jsonDecode(
      res.body,
    )['data'].map<EmpListModel>((e) => EmpListModel.fromJson(e)).toList();
    log('최종 getEmpList : ${Data.empList.toString()}');
  }

  static Future<bool> postCreatChat(
    TextEditingController title,
    List<int> list,
    String prefsToken,
  ) async {
    final headersWithToken = headers;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await post(
      Uri.parse('$baseUrl/chatrooms/create'),
      headers: headersWithToken,
      body: jsonEncode({
        'roomName': title.text,
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

  static Future<void> getMessagesInt(prefsToken) async {
    final headersWithToken = headers;
    headersWithToken['Authorization'] = 'Bearer $prefsToken';
    final res = await get(
      Uri.parse('$baseUrl/messages/unread'),
      headers: headersWithToken,
    );
    Data.chatInt = jsonDecode(res.body)['data']['totalCount'];
  }
}
