import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Utils {
  static svg(String name, double size, Color? color) {
    return SvgPicture.asset(
      'assets/$name.svg',
      width: size,
      color: color,
    );
  }

  static people(String name, double size) {
    return Image.asset(
      'assets/people/$name.jpg',
      width: size,
      fit: BoxFit.cover,
    );
  }

  static List<String> peopleName = [
    '김지훈 대리',
    '이서연 사원',
    '박민수 과장',
    '최유진 사원',
    '정우빈 팀장',
    '한지민 대리',
    '서민재 사원',
    '오세훈 대리',
    '강하늘 과장',
    'ㅇㅇㅇ ㅇㅇ',
  ];
}
