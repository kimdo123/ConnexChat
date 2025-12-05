import 'package:connex_chat/controllers/c_user.dart';
import 'package:connex_chat/views/common/w_custom_text_field.dart';

import '../../app/core.dart';
import '../../app/utils.dart';

class EditChatDialogWidget extends StatefulWidget {
  const EditChatDialogWidget({
    super.key,
    this.roomname,
  });

  final String? roomname;

  @override
  State<EditChatDialogWidget> createState() => _EditChatDialogWidgetState();
}

class _EditChatDialogWidgetState extends State<EditChatDialogWidget> {
  // 변수 --------------
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
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
            height: 200,
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
                          widget.roomname ?? '채팅방 이름',
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
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        log('수정');
                      },
                      child: Text(
                        '채팅방 정보 수정',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // allChatRoomMap.remove(widget.roomname);
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        '나가기',
                        style: TextStyle(fontSize: 16),
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
}
