import 'package:demo_app/presentation/splash_screen/binding/splash_binding.dart';
import 'package:demo_app/presentation/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../presentation/home_screen/binding/home_binding.dart';
import '../presentation/home_screen/home_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home_screen';
  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(name: homeScreen, page: () => HomeScreen(), bindings: [
      HomeBinding(),
    ]),
  ];
}
