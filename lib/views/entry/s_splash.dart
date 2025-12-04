import 'package:connex_chat/app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  // ------------변수
  late final Animation<double> animationLogo;
  late final Animation<double> animationTitleFade;
  late final Animation<Offset> animationTitleOffset;
  late final Animation<double> animationNext;
  late final Animation<double> animationBackgournd;
  late final Animation<Offset> animationLoop;

  late final AnimationController controllerLogo;
  late final AnimationController controllerTitle;
  late final AnimationController controllerNext;
  late final AnimationController controllerBackground;
  late final AnimationController controllerLoop;

  // NEXT 버튼 애니메이션 반복
  bool loop = false;

  // 애니메이션
  double box = 200;

  // 드래그 위치
  double dragPosition = 0.0;

  // 로컬 저장 prefs
  late SharedPreferences prefs;

  @override
  void dispose() {
    controllerLogo.dispose();
    controllerTitle.dispose();
    controllerNext.dispose();
    controllerBackground.dispose();
    controllerLoop.dispose();
    super.dispose();
  }

  // ------------init\
  @override
  void initState() {
    super.initState();
    initprefs();
    init();
    initAnimation();
  }

  // 로컬 변수 불러오기
  Future<void> initprefs() async {
    prefs = await SharedPreferences.getInstance();
    // log('로컬 변수 불러오기');
  }

  // 에니메이션 시작 함수
  Future<void> initAnimation() async {
    // 로고 애니메이션
    controllerLogo.forward().then((value) {
      Future.delayed(Duration(milliseconds: 300), () {
        // Connex Chat 애니메이션
        setState(() {
          box = 0;
        });
        // 브랜드 메세지 애니메이션
        Future.delayed(Duration(seconds: 1), () {
          controllerTitle.forward().then((value) {
            // Next 버튼 애니메이션
            controllerNext.forward().then((value) {
              // Next 버튼 뒤에 배경 애니메이션
              controllerBackground.forward().then((value) {
                // 반복 애니메이션
                controllerLoop.repeat(reverse: true);
              });
            });
          });
        });
      });
    });
  }

  void init() {
    controllerLogo = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controllerLogo, curve: Curves.easeInOutBack),
    );
    controllerTitle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationTitleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controllerTitle, curve: Curves.easeInOut),
    );
    animationTitleOffset = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: controllerTitle, curve: Curves.easeInOut),
        );
    controllerNext = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationNext = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controllerNext, curve: Curves.easeIn));
    controllerBackground = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationBackgournd = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controllerBackground, curve: Curves.easeIn),
    );
    controllerLoop = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationLoop = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.1),
    ).animate(CurvedAnimation(parent: controllerLoop, curve: Curves.easeInOut));
  }

  // ------------화면
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: animationLogo,
                  child: RotationTransition(
                    turns: animationLogo,
                    child: Utils.svgFromAsset('logo', null, Colors.white),
                    // child: Utils.svg('logo', null, Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Stack(
                    children: [
                      Text(
                        'Connex Chat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          width: box,
                          height: 40,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: animationTitleFade,
              child: SlideTransition(
                position: animationTitleOffset,
                child: Text(
                  '언제 어디서든 안정적인 근무 환경을 위해',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(height: MediaQuery.of(context).size.height * 0.3),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: -5,
                      child: FadeTransition(
                        opacity: animationBackgournd,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          width: 70,
                          height: 150,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      child: FadeTransition(
                        opacity: controllerBackground,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Row(
                            children: [
                              Utils.svgFromAsset(
                                'back',
                                20,
                                Colors.white.withOpacity(0.5),
                              ),
                              Utils.svgFromAsset(
                                'back',
                                20,
                                Colors.white.withOpacity(1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: animationLoop,
                      child: GestureDetector(
                        // 드래그 시작 했을때
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            // 드래그 반영
                            dragPosition += details.primaryDelta ?? 0;
                            // 올릴수 있는 최대치 정하기
                            if (dragPosition > 0) {
                              dragPosition = 0;
                            } else if (dragPosition < -70) {
                              dragPosition = -70;
                            }
                          });
                        },
                        // 드래그 놨을때
                        onVerticalDragEnd: (details) async {
                          // 일정 수치 이상이면 넘어가기
                          if (dragPosition < -50) {
                            prefs.setBool('isSplashPassed', true);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                            log('다음부터 splash 스킵');
                          } else {
                            // 아니면 위치 초기화
                            setState(() {
                              dragPosition = 0.0;
                            });
                          }
                        },
                        // Transform.translate 위젯으로 드래그 위치 반영
                        child: Transform.translate(
                          offset: Offset(0, dragPosition),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FadeTransition(
                                opacity: animationNext,
                                child: ClipOval(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 60,
                                    color: Colors.white,
                                    child: Text(
                                      'NEXT',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
