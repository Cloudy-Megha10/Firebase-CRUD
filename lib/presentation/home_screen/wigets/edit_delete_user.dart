import 'dart:io';
import 'package:demo_app/core/utils/size_utils.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/presentation/home_screen/models/user_fields.dart';
import 'package:demo_app/widgets/custom_button.dart';
import 'package:demo_app/widgets/custom_image_view.dart';
import 'package:demo_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  final HomeController controller =
      Get.put(HomeController()); // Initialize the controller

  Widget allUserDataList() {
    return Obx(() {
      if (controller.userModelObj.usersList.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: controller.userModelObj.usersList
            .length, // Use the length of users to avoid out-of-bounds errors
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.purple.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade700, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                            child: CustomImageView(
                          imageBytes:
                              controller.userModelObj.usersList[index].images,
                          height: getSize(150),
                          width: getSize(150),
                          fit: BoxFit.cover,
                        )),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var field in [
                                'lbl_name'.tr,
                                'lbl_class'.tr,
                                'lbl_gender'.tr,
                                'lbl_age'.tr,
                                'lbl_address'.tr
                              ])
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$field: ',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'Aller',
                                          ),
                                        ),
                                        TextSpan(
                                          text: _getFieldValue(
                                              field,
                                              controller.userModelObj
                                                  .usersList[index]),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black54,
                                            fontFamily: 'Aller',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'lbl_edit'.tr,
                            shape: ButtonShape.RoundedBorder20,
                            variant: ButtonVariant.FillLightPurple,
                            fontStyle: ButtonFontStyle.PurpleSemiBold14,
                            onTap: () async {
                              // Populate the form fields with user data
                              controller.nameController.text =
                                  controller.userModelObj.usersList[index].name;
                              controller.classController.text = controller
                                  .userModelObj.usersList[index].className;
                              controller.genderController.text = controller
                                  .userModelObj.usersList[index].gender;
                              controller.ageController.text =
                                  controller.userModelObj.usersList[index].age;
                              controller.addressController.text = controller
                                  .userModelObj.usersList[index].address;

                              if (controller.userModelObj.usersList[index]
                                          .images !=
                                      null &&
                                  controller.userModelObj.usersList[index]
                                      .images.isNotEmpty) {
                                controller.decodeAndSaveImage(controller
                                    .userModelObj.usersList[index].images);
                              } else {
                                controller.imageFile.value = null;
                                print("Image data is null or empty");
                              }
                              // Call the edit method
                              editUserDetail(context,
                                  controller.userModelObj.usersList[index].id);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                              text: "lbl_delete".tr,
                              variant: ButtonVariant.FillDarkPurple,
                              shape: ButtonShape.RoundedBorder20,
                              fontStyle: ButtonFontStyle.WhiteSemiBold14,
                              onTap: () async {
                                await deleteUserData(
                                    context,
                                    controller
                                        .userModelObj.usersList[index].id);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Future deleteUserData(BuildContext context, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 130.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'lbl_want_delete'.tr,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.purple.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Center(
                    child: CustomButton(
                      text: "lbl_delete_user".tr,
                      shape: ButtonShape.RoundedBorder20,
                      variant: ButtonVariant.FillDarkPurple,
                      onTap: () async {
                        await DatabaseMethods()
                            .deleteUserData(id)
                            .then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: 'lbl_data_deleted'.tr,
                              textColor: Colors.red);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future editUserDetail(BuildContext context, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              child: AlertDialog(
            content: Container(
              //height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'lbl_edit_user'.tr,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.clearTextFields();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.purple.shade700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Obx(() {
                      return SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            // Display file image if userData['Image'] is a valid file path
                            ClipOval(
                              child: CustomImageView(
                                file: File(controller.imageFile.value!.path),
                                height: getSize(200),
                                width: getSize(200),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  elevation: 2.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'lbl_name'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.nameController,
                    variant: TextFormFieldVariant.OutlineGray900,
                    isObscureText: false,
                    shape: TextFormFieldShape.RoundedBorder16,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'lbl_class'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.classController,
                    variant: TextFormFieldVariant.OutlineGray900,
                    isObscureText: false,
                    shape: TextFormFieldShape.RoundedBorder16,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'lbl_gender'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.genderController,
                    variant: TextFormFieldVariant.OutlineGray900,
                    isObscureText: false,
                    shape: TextFormFieldShape.RoundedBorder16,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'lbl_age'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.ageController,
                    variant: TextFormFieldVariant.OutlineGray900,
                    isObscureText: false,
                    shape: TextFormFieldShape.RoundedBorder16,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'lbl_address'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.addressController,
                    variant: TextFormFieldVariant.OutlineGray900,
                    isObscureText: false,
                    shape: TextFormFieldShape.RoundedBorder16,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: CustomButton(
                      text: 'lbl_update_user'.tr,
                      variant: ButtonVariant.FillDarkPurple,
                      fontStyle: ButtonFontStyle.WhiteSemiBold14,
                      shape: ButtonShape.RoundedBorder20,
                      onTap: () async {
                        onTapUpdateUser(id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: controller.fetchUsers,
      child: allUserDataList(),
    ));
  }

  String _getFieldValue(String field, UserFieldsModel user) {
    switch (field) {
      case 'Name':
        return user.name ?? ""; // Assuming 'name' property exists
      case 'Class':
        return user.className ?? ""; // Assuming 'className' property exists
      case 'Gender':
        return user.gender ?? ""; // Assuming 'gender' property exists
      case 'Age':
        return user.age?.toString() ??
            ""; // Assuming 'age' property exists and is an int
      case 'Address':
        return user.address ?? ""; // Assuming 'address' property exists
      default:
        return "";
    }
  }

  onTapUpdateUser(id) async {
    print("edituserID$id");
    await controller.updateNewUser(
        id: id,
        name: controller.nameController.text,
        stdClass: controller.classController.text,
        gender: controller.genderController.text,
        age: controller.ageController.text,
        address: controller.addressController.text,
        image: controller.imageFile.value!.path);
  }
}
