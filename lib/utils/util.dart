import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Utils {
  static svg(String name, double? size, Color? color) {
    return SvgPicture.asset(
      'assets/svg/$name.svg',
      width: size,
      color: color,
    );
  }

  static people(String name, double size) {
    return Image.asset(
      'assets/people/$name.jpg',
      width: size,
      cacheWidth: size.toInt(),
      fit: BoxFit.cover,
    );
  }
}
