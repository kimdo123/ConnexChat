import 'dart:convert';
import 'dart:developer';
import 'package:connex_chat/controller/data.dart';
import 'package:connex_chat/model/m_dmp_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

final String baseUrl = 'http://arkenzo.dothome.co.kr/connexchat';
final headers = {
  'Content-type': 'application/json',
};

late String token;
late final String profileName;

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
    profileName = jsonDecode(res.body)['data']['name'].toString();
    return jsonDecode(res.body)['success'];
  }


  static Future<void> getEmpList() async {
    final headersWithToken = headers;
    headersWithToken['Authorization'] = 'Bearer $token';
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
}
