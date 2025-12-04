import 'package:connex_chat/app/core.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Utils {
  static SvgPicture svgFromAsset(
    String fileName,
    double? widthSize,
    Color color,
  ) {
    return SvgPicture.asset(
      'assets/svg/$fileName.svg',
      width: widthSize,
      color: color,
    );
  }

  static Image peopleImage(String fileName, double widthSize) {
    return Image.asset(
      'assets/people/$fileName.jpg',
      width: widthSize,
      cacheWidth: widthSize.toInt(),
      fit: BoxFit.cover,
    );
  }
}
