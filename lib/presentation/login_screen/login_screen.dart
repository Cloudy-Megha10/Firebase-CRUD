

import 'dart:math';

import 'package:demo_app/core/utils/color_constant.dart';
import 'package:demo_app/localization/en_us/app_localization.dart';
import 'package:demo_app/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

import '../../core/utils/size_utils.dart';
import '../../core/utils/validation_functions.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});


 @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo section
            Container(
              width: double.infinity,
              height: size.height * 0.40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.red], // Gradient colors
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  ClipOval(child: Image.asset(
                    'assets/images/samraat_international.jpg', // Add your logo image path
                    height: 150,
                  ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Login heading
             Text(
              'lbl_login'.tr,
              style: AppStyle.txtAllerBold28
            ),
            
            const SizedBox(height: 20),

           // Login heading
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Username label
      Text(
        'lbl_username'.tr,
        style: AppStyle.txtAllerBold20,
      ),

      // Username field
      CustomTextFormField(
        controller: controller.userNameController,
        hintText: "lbl_enter_username".tr, // Changed from prefixText to hintText
        isObscureText: false, // Usernames aren't typically obscured
        margin: getMargin(top: 13),
        width: 300,
        shape: TextFormFieldShape.RoundedBorder16,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null ||
              (!isValidUserName(value, isRequired: true))) {
            return "lbl_enter_valid_username".tr;
          }
          return null;
        },
      ),

      const SizedBox(height: 20),

      // Password label
      Text(
        'lbl_password'.tr, // Changed label to "Password"
        style: AppStyle.txtAllerBold20,
      ),

      // Password field
     Obx(() => CustomTextFormField(
        controller: controller.passwordController,
        hintText: "lbl_enter_password".tr, // Hint text instead of prefixText
        isObscureText: controller.isPasswordVisible.value, // Usernames aren't typically obscured // Hide text for password field
        margin: getMargin(top: 13),
        width: 300,
        shape: TextFormFieldShape.RoundedBorder16,
        textInputType: TextInputType.visiblePassword, // Use appropriate type
         suffix: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    controller.togglePasswordVisibility(); // Toggle visibility
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "lbl_enter_valid_password".tr;
                  }
                  return null;
                },
      ),)
    ],
  ),
),
            
            // Forgot Password link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot Password action
                  },
                  child: Text(
                    'lbl_forgot_password'.tr,
                    style: AppStyle.txtAllerBoldRed
                  ),
                ),
              ),
            ),
           SizedBox(height: 10,),
            // Login button
             CustomButton(
                                                            height:
                                                                getVerticalSize(
                                                                    52),
                                                            width:
                                                                getHorizontalSize(
                                                                    320),
                                                            text: "lbl_login"
                                                                .tr,
                                                            margin: getMargin(
                                                                top: 34),
                                                            onTap: () {
                                                              onTapSigninwith();
                                                            }),
          
          ],
        ),
      ),
    );
  }
  onTapSigninwith() async {
    print("login true");
    print(controller.userNameController.text);
    print(controller.passwordController.text);
    if (controller.userNameController.text.isEmpty ||
        controller.passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "lbl_enter_valid_credentials".tr,
        backgroundColor: Colors.grey,
      );
    } else {
      await controller.login(userName: controller.userNameController.text, password: controller.passwordController.text);
    }
}
}