// Pages with dynamic content
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:demo_app/core/utils/image_constant.dart';
import 'package:demo_app/core/utils/size_utils.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/presentation/home_screen/models/user_fields.dart';
import 'package:demo_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

class DashboardPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController()); // Initialize the controller

  Widget allUserDataList() {
    return  Obx(() {
    if (controller
                                              .userModelObj
                                              .usersList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
  itemCount: controller
                                              .userModelObj
                                              .usersList
                                              .length,  // Use the length of users to avoid out-of-bounds errors
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
  child: 
    Image.memory(controller
                                                                .userModelObj
                                                                .usersList[
                                                                    index]
                                                                .images,
        height: getSize(150),
        width: getSize(150),
        fit: BoxFit.cover,
      )
),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var field in ['Name', 'Class', 'Gender', 'Age', 'Address'])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
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
                                    text:_getFieldValue(field, controller.userModelObj.usersList[index]),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade100),
                      onPressed: () async {
                        // Populate the form fields with user data
                        controller.nameController.text = controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .name;
                        controller.classController.text = controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .className;
                        controller.genderController.text = controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .gender;
                        controller.ageController.text = controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .age;
                        controller.addressController.text = controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .address;

                                                                        if (controller.userModelObj.usersList[index].images != null && controller.userModelObj.usersList[index].images.isNotEmpty) {
  controller.decodeAndSaveImage(controller.userModelObj.usersList[index].images);
} else {
  controller.imageFile.value = null;
  print("Image data is null or empty");
}
                        // Call the edit method
                        editUserDetail(context,  controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .id);
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade700,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Call the delete method
                        deleteUserData(context, controller
                                                                        .userModelObj
                                                                        .usersList[
                                                                            index]
                                                                        .id);
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
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

});}


Future deleteUserData(BuildContext context,String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: 
            Container(
              height: 130.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Are you sure ? Want to delete data ?',
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade700),
                      onPressed: () async {
                        await DatabaseMethods()
                            .deleteUserData(id)
                            .then((value) {
                          Navigator.pop(context);
                         Fluttertoast.showToast(msg: 
                              'Data Deleted Successfully', textColor:  Colors.red);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Delete User Data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

 Future editUserDetail(BuildContext context,String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(child: 
          AlertDialog(
            content: 
            Container(
              //height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit User Detail',
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
             child:Obx(() {
        return
              SizedBox(
                   height: 115,
                   width: 115,
                   child: Stack(
                     clipBehavior: Clip.none,
                     fit: StackFit.expand,
                     children: [
                        if (controller.imageFile.value?.path != null && controller.imageFile.value!.path.contains('assets/'))
      ClipOval(
        child: Image.asset(
          controller.imageFile.value!.path, // Load the image as an asset
          height: getSize(200),
          width: getSize(200),
          fit: BoxFit.cover, // Use BoxFit.cover to fill the oval without cutting off
        ),
      ),

    SizedBox(height: 20), // Add spacing between images

    // Display file image if userData['Image'] is a valid file path
    if (controller.imageFile.value?.path != null && !controller.imageFile.value!.path.contains('assets/'))
      ClipOval(
        child: CustomImageView(
          file: File(controller.imageFile.value!.path),
          height: getSize(200),
          width: getSize(200),
        ),),
                       Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: () {
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
             );
        }),),
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
                    height: 40.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade700),
                      onPressed: () async {
                        onTapUpdateUser(id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Update User',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
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
child:allUserDataList(),
    )
    );
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
      return user.age?.toString() ?? ""; // Assuming 'age' property exists and is an int
    case 'Address':
      return user.address ?? ""; // Assuming 'address' property exists
    default:
      return "";
  }
}

  onTapUpdateUser(id) async{
    print("edituserID$id");
    await controller.updateNewUser(id:id,name: controller.nameController.text, stdClass: controller.classController.text, gender: controller.genderController.text, age: controller.ageController.text, address: controller.addressController.text, image: controller.imageFile.value!.path);
  }

}