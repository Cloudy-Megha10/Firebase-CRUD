import 'package:demo_app/core/network/dependency_injection.dart';
import 'package:demo_app/core/utils/logger.dart';
import 'package:demo_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'localization/en_us/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
    DependencyInjection.onInit();
  });
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //title: 'Flutter Demo',
      translations: AppLocalization(),
      locale: Get.deviceLocale, //for setting localization strings
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       visualDensity: VisualDensity.standard,
    ),
    initialRoute: AppRoutes.splashScreen,
    getPages: AppRoutes.pages,
    );
  }
}

