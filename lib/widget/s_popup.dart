import 'dart:developer';
import 'package:connex_chat/utils/util.dart';
import 'package:connex_chat/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void openDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return DialogWidget();
    },
  );
}

class DialogWidget extends StatefulWidget {
  const DialogWidget({
    super.key,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  // 변수 --------------
  late TextEditingController sectionTitleController;
  late TextEditingController chatTitleController;

  @override
  void initState() {
    super.initState();
    sectionTitleController = TextEditingController();
    chatTitleController = TextEditingController();
  }

  @override
  void dispose() {
    sectionTitleController.dispose();
    chatTitleController.dispose();
    super.dispose();
  }

  // 화면 --------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 350,
              height: 350,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '채팅방 생성하기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              log('Close');
                            },
                            child: Utils.svg('close', 24, Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        label: '색션 이름을 입력해 주세요',
                        controller: sectionTitleController,
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        label: '채팅방 이름을 입력해주세요',
                        controller: chatTitleController,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, index) => SizedBox(width: 10),
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return selectePeople(index);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            log('생성하기');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            minimumSize: Size(350, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '생성하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectePeople(int index) {
    return Stack(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Utils.people('employee${index + 1}', 40),
              ),
            ),
            SizedBox(width: 5),
            Text(
              Utils.peopleName[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
