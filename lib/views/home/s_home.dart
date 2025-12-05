import 'package:connex_chat/app/utils.dart';
import 'package:connex_chat/controllers/c_user.dart';
import 'package:connex_chat/views/chat/s_chat.dart';

import '../../app/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> futureFunc;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await UserController.getEmpList(prefs.getString('token').toString());
    await UserController.getUserinfo(prefs.getString('token').toString());
    await UserController.getMessagesInt(prefs.getString('token').toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Utils.svgFromAsset(
                                  'person_fill',
                                  40,
                                  Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            prefs.getString('username').toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '읽지 않은 대화가 $chatInt개 있어요!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            chatCard(),
                                        itemCount: chatInt,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '사원 목록',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 350,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Utils.peopleImage(
                                              'employee${empList[index].id}',
                                              40,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(empList[index].name),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: empList.length,
                                ),
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
          );
        }
      },
    );
  }

  Widget chatCard() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        // log 왜 안써짐?
        onTap: () {
          log('채팅방 이동');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.5),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          width: 140,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 30,
                        child: ClipOval(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Utils.peopleImage('employee3', 24),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        child: ClipOval(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Utils.peopleImage('employee2', 24),
                          ),
                        ),
                      ),
                      Positioned(
                        child: ClipOval(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Utils.peopleImage('employee1', 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '채팅방 이름',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('대화 내용입니다...', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
