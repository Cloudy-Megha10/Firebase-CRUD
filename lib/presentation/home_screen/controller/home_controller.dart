import 'package:demo_app/core/utils/flutter_secure_storage.dart';
import 'package:demo_app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  SecureStorage _secureStorage = SecureStorage();
  RxString userName = ''.obs;
  RxString userRole = ''.obs;
@override
void onReady() async {
  super.onReady();
   userName.value = (await _secureStorage.getUserName())!;
   userRole.value = (await _secureStorage.getUserRole())!;
   print("userRole");
   print(userRole.value);
}

 var selectedIndex = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void removeAll() async{
    await _secureStorage.removeAll();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

@override
  void onClose() {
    super.onClose();
  }
}