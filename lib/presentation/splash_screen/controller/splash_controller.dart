import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController{
  @override
  void onReady(){
    super.onReady();
     Future.delayed(const Duration(milliseconds: 4000), () {
      Get.offAllNamed(AppRoutes.loginScreen);
    });
  }
}