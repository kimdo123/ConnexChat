import 'package:connex_chat/app/utils.dart';
import 'package:connex_chat/views/chat/s_chat.dart';
import 'package:connex_chat/views/home/s_home.dart';
import 'package:connex_chat/views/profile/s_profile.dart';
import '../../app/core.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  // 변수 -------------------
  int _selectedIdx = 0;

  List<Widget> get _page => [
    HomeScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  // 화면 -------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIdx,
        children: _page,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    blurRadius: 5,
                    offset: Offset(0, 1)
                ),
              ],
              borderRadius: BorderRadius.circular(100)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _selectedIdx,
              onTap: (index) {
                setState(() {
                  _selectedIdx = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Utils.svgFromAsset('home_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svgFromAsset('home_fill', 25, Colors.deepPurple),
                ),
                BottomNavigationBarItem(
                  label: 'Chat',
                  icon: Utils.svgFromAsset('chat_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svgFromAsset('chat_fill', 25, Colors.deepPurple),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Utils.svgFromAsset('person_outline', 25, Colors.deepPurple),
                  activeIcon: Utils.svgFromAsset('person_fill', 25, Colors.deepPurple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
