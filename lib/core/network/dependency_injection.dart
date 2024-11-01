import 'package:demo_app/core/network/network_info.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void onInit() {
    Get.put<NetworkInfo>(NetworkInfo(), permanent: true);
  }
}
