import 'package:connex_chat/utils/util.dart';
import 'package:connex_chat/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 변수 -------------------------------------
  late TextEditingController email;
  late TextEditingController password;

  // init ------------------------------------
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  // dispose ------------------------------------
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // 화면 -------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(20, 50, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Utils.svg('logo', null, Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Connex Chat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    '안녕하세요!',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Connex Chat과 함께 오늘도 활기찬 하루되세요',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(30, 30, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        label: '이메일을 입력해주세요',
                        controller: email,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomTextFormField(
                        label: '비밀번호를 입력해주세요',
                        controller: password,
                      ),
                      SizedBox(height: 200),
                      buttons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/home'),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '로그인 하기',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepPurple,
            ),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                '회원가입 하러 가기',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () => showSnackBar('아직 완성되지 않은 기능입니다.', context),
        ),
      ],
    );
  }

  void showSnackBar(String text, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text))
    );
  }
}
