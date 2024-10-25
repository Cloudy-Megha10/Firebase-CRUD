import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController{
  Future<void> requestStoragePermission() async {
  if (!await Permission.storage.isGranted) {
    await Permission.storage.request();
  }
}
  @override
  void onReady(){
    super.onReady();
    requestStoragePermission();
     Future.delayed(const Duration(milliseconds: 4000), () {
      Get.offAllNamed(AppRoutes.homeScreen);
    });
  }
}