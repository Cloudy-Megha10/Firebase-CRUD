import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class AppStyle {
static TextStyle txtAllerBold28 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      28,
    ),
    fontFamily: 'Aller',
    fontWeight: FontWeight.w700,
  );
  static TextStyle txtAllerBold20 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      20,
    ),
    fontFamily: 'Aller',
    fontWeight: FontWeight.normal,
  );
  static TextStyle txtAllerBoldRed = TextStyle(
    color: ColorConstant.darkRed,
    fontSize: getFontSize(
      18,
    ),
    fontFamily: 'Aller',
    fontWeight: FontWeight.bold,
  );
}