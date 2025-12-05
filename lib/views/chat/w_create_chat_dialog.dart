import 'package:connex_chat/controllers/c_user.dart';
import 'package:connex_chat/views/common/w_custom_text_field.dart';

import '../../app/core.dart';
import '../../app/utils.dart';

class CreateChatDialogWidget extends StatefulWidget {
  const CreateChatDialogWidget({
    super.key,
  });

  @override
  State<CreateChatDialogWidget> createState() => _CreateChatDialogWidgetState();
}

class _CreateChatDialogWidgetState extends State<CreateChatDialogWidget> {
  // 변수 --------------
  late TextEditingController sectionController;
  late TextEditingController titleController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    sectionController = TextEditingController();
    titleController = TextEditingController();
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    sectionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  // 화면 --------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 350,
            height: 350,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: EdgeInsets.all(20),
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
                            Navigator.pop(context);
                            log('엑스 버튼 클릭');
                          },
                          child: Utils.svgFromAsset('close', 24, Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      label: '색션 이름을 입력해 주세요',
                      controller: sectionController,
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      label: '채팅방 이름을 입력해주세요',
                      controller: titleController,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      height: 40,
                      // .separated : ListView 아이템들 간격 설정
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
                        onPressed: () async {
                          final isSuccessed =
                              await UserController.postCreatChat(
                                titleController.text,
                                selected,
                                prefs.getString('token').toString(),
                              );
                          if (isSuccessed) {
                            Navigator.pop(context, titleController.text);
                            log('채팅방 생성 완료');
                          } else {
                            log('채팅방 생성 실패');
                          }
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
      ],
    );
  }

  List<int> selected = [];

  Widget selectePeople(int index) {
    return GestureDetector(
      onTap: () {
        if (!selected.contains(index)) {
          setState(() {
            selected.add(index);
            log(selected.toString());
            log('선택 [$index]');
          });
        } else {
          setState(() {
            selected.remove(index);
            log(selected.toString());
            log('선택 헤제 [$index]');
          });
        }
      },
      child: Row(
        children: [
          SizedBox(width: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Stack(
                children: [
                  Utils.peopleImage('employee${index + 1}', 40),
                  Container(
                    color: selected.contains(index)
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ),

          Text(
            empList[index].name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected.contains(index) ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
