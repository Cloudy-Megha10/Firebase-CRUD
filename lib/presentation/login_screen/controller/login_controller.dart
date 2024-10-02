import 'package:demo_app/core/utils/flutter_secure_storage.dart';
import 'package:demo_app/presentation/login_screen/controller/login_repository.dart';
import 'package:demo_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../data/apiClient/common_response.dart';
import '../models/login_response.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginRepository _loginRepository = LoginRepository();
  SecureStorage _secureStorage = SecureStorage();
  RxString userId = ''.obs;
  @override
  void onReady() async{
    super.onReady();
    try{
    userId.value = (await _secureStorage.getUserId())!;
    print("homeScreen");
    (userId.value != "null" ? Get.offAllNamed(AppRoutes.homeScreen) : Get.offAllNamed(AppRoutes.loginScreen));
  }catch(error){
    print(error);
  }
  }

   RxBool isPasswordVisible = false.obs; // Reactive boolean

  // Toggle the password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    try {
      CommonResponse<LoginResponse> loginUserResult =
          await _loginRepository.loginUserData( 
              userName,
              password,
             );
        if (loginUserResult.status == true) {
          print("loginUserResult");
          Fluttertoast.showToast(
          msg: loginUserResult.message,
          backgroundColor: Colors.grey,
        );
        print("success");
        _secureStorage.setUserId(loginUserResult.data!.data!.userId.toString());
        _secureStorage.setUserName(loginUserResult.data!.data!.username.toString());
        _secureStorage.setUserRole(loginUserResult.data!.data!.role.toString());
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        print("failure");
        print(loginUserResult.data);
        print(loginUserResult.message);
        Fluttertoast.showToast(
          msg: loginUserResult.message,
          backgroundColor: Colors.grey,
        );
        print("fail");
        
      }
    } catch (e) {
      String errormsg = "Error in Catch Block" + e.toString();
      print("error");
      print(errormsg);
    }
  }

  @override
  void onClose(){
    super.onClose();
  }
}