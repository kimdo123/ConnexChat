import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  // ------------변수
  late final Animation<double> animationLogo;
  late final Animation<double> animationAFade;
  late final Animation<Offset> animationAOffset;
  late final Animation<double> animationB;
  late final Animation<double> animationC;
  late final Animation<double> animationD;

  late final AnimationController controllerLogo;
  late final AnimationController controllerA;
  late final AnimationController controllerB;
  late final AnimationController controllerC;
  late final AnimationController controllerD;

  double box = 200;

  @override
  void dispose() {
    controllerLogo.dispose();
    controllerA.dispose();
    controllerB.dispose();
    controllerC.dispose();
    controllerD.dispose();
    super.dispose();
  }

  // ------------init\
  @override
  void initState() {
    super.initState();
    init();
    animation();
  }

  // 에니메이션 시작 함수
  Future<void> animation() async {
    controllerLogo.forward().then((value) {
      Future.delayed(Duration(milliseconds: 300), () {
        log('animationLOGO complite');
        setState(() {
          box = 0;
        });
        log('animation ConnexChat comlite');
        Future.delayed(Duration(seconds: 1), () {
          controllerA.forward();
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
    controllerA = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationAFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controllerA, curve: Curves.linear));
    animationAOffset =
        Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controllerA,
            curve: Curves.easeInOut,
          ),
        );
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
                // TODO animation 디테일 추가 필요
                ScaleTransition(
                  scale: animationLogo,
                  child: RotationTransition(
                    turns: animationLogo,
                    child: SvgPicture.asset(
                      'assets/logo.svg',
                      color: Colors.white,
                    ),
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
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: animationAFade,
              child: SlideTransition(
                position: animationAOffset,
                child: Text(
                  '언제 어디서든 안정적인 근무 환경을 위해',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.black,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.white,
                      ),
                    ),
                    Text('NEXT'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
