import 'dart:convert';
import 'dart:io';

import 'package:demo_app/core/utils/image_constant.dart';
import 'package:demo_app/core/utils/size_utils.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/widgets/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class AddNewData extends StatelessWidget {
final HomeController controller = Get.put(HomeController()); // Initialize the controller
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade700,
        title: const Text(
          'Add New User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Center(
             child:Obx(() {
        return
              SizedBox(
                   height: 115,
                   width: 115,
                   child: Stack(
                     clipBehavior: Clip.none,
                     fit: StackFit.expand,
                     children: [(controller.imageFile.value?.path == null || controller.imageFile.value?.path.isEmpty == true)?
                     ClipOval(
              child:  
              CustomImageView(
          imagePath:ImageConstant.logo,
          height: getSize(200),
          width: getSize(200)
        )):
       ClipOval(
              child:  
              CustomImageView(
          file:File(controller.imageFile.value!.path),
          height: getSize(200),
          width: getSize(200)
        
                       ),),
                       Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: () {
                   print("cameraico");
                   controller.pickImage();
                  },
          
                  elevation: 2.0,
                  fillColor: Color(0xFFF5F6F9),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                  padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
                )),
                     ],
                   ),
                 );}),
           ),
            SizedBox(
              height: 5.0,
            ),
            const Text(
              'Name',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller.nameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Class',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller.classController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
             const Text(
              'Gender',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller.genderController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Age',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller.ageController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
             const Text(
              'Address',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
          Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller.addressController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade700
                ),
                onPressed: () async {
                  print('add');
                  onTapAddUser();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  child: Text(
                    'Add User',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  onTapAddUser() async{
    print("ADDUSER");
    await controller.addNewUser(id:randomAlphaNumeric(8),name: controller.nameController.text, stdClass: controller.classController.text, gender: controller.genderController.text, age: controller.ageController.text, address: controller.addressController.text, image: controller.imageFile.value?.path ?? ImageConstant.logo);
  }
  
}