import 'package:flutter/material.dart';

class ColorConstant {
  static Color whiteA700 = fromHex('#ffffff');
  static Color black900 = fromHex('#000000');
  static Color darkRed = fromHex('#FF0000');
  static Color lightGrey = fromHex('#E8E9EB');
  static Color lightPurple = fromHex('#E1BEE7');
  static Color darkPurple = fromHex('#7B1FA2');
  static Color purpleShade = fromHex('#7E57C2');
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}