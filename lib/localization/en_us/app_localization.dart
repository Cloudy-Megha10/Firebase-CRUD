import 'package:demo_app/localization/en_us/en_us_translations.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppLocalization extends Translations {
  @override
  Map<String,Map<String,String>> get keys => {'en_US':enUs};
}