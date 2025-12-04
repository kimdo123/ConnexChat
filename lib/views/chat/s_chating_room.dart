import '../../app/core.dart';

class ChattingRoomScreen extends StatefulWidget {
  const ChattingRoomScreen({super.key});

  @override
  State<ChattingRoomScreen> createState() => _SChattingRoomState();
}

class _SChattingRoomState extends State<ChattingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('asd')
          ],
        ),
      ),
    );
  }
}