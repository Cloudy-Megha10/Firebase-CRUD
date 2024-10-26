import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/data/apiClient/common_response.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:demo_app/presentation/home_screen/controller/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  var imageFileList = <File>[].obs;  // Observable list of image files
  var userImageFiles = <File>[].obs;  // Observable list to hold image files
   TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  HomeRepository _homeRepository = HomeRepository();

  RxString userName = ''.obs;
  RxString userRole = ''.obs;
   var selectedIndex = 2.obs;
    // Observable list to hold user data
  var users = <Map<String, dynamic>>[].obs; // Assuming user data is a map
  Stream<QuerySnapshot>? userStream;
    var imageFile = Rxn<File>();
      Rxn<Uint8List> imageBytes = Rxn<Uint8List>(); // Store the Base64-decoded image bytes

@override
void onReady() async{
  super.onReady();
  fetchUsers();
  //listenToUserStream();
}

 void decodeBase64Image(String base64String) {
  print("decode");
    try {
      imageBytes.value = base64Decode(base64String);
    } catch (e) {
      print("Error decoding base64 image: $e");
      imageBytes.value = null; // Clear on error if necessary
    }
  }


Future<void> addNewUser({
  required String id,
  required String name,
  required String stdClass,
  required String gender,
  required String age,
  required String address,
  required String image, // Ensure this is the correct file path to the image
}) async {
  try {
    String base64Image;

    // Check if the image is from the assets folder
    if (image.startsWith('assets/')) {
      // Load image from assets
      ByteData byteData = await rootBundle.load(image); // e.g., 'assets/images/logo.jpg'
      List<int> imageBytes = byteData.buffer.asUint8List();
      base64Image = base64Encode(imageBytes);
      print("Asset base64Image: $base64Image");
    } else {
      // Load image from file
      File file = File(image);

      if (!await file.exists()) {
        print("File not found at path: $image");
        Fluttertoast.showToast(
          msg: "Image file not found!",
          backgroundColor: Colors.red,
        );
        return;
      }

      // Read image bytes
      List<int> imageBytes = await file.readAsBytes();

      // Convert the image bytes to a Base64 string
      base64Image = base64Encode(imageBytes);
      print("File base64Image: $base64Image");
    }

    // Sending data to the repository
    CommonResponse addedUserResult = await _homeRepository.addUserData(
      id,
      name,
      stdClass,
      gender,
      age,
      address,
      base64Image,
    );

    // Handling the response
    if (addedUserResult.status == true) {
      Fluttertoast.showToast(
        msg: addedUserResult.message,
        backgroundColor: Colors.green,
      );
      print("User added successfully: ${addedUserResult.message}");
            clearTextFields();
            Get.back();
            //Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: addedUserResult.message,
        backgroundColor: Colors.grey,
      );
      print("Failed to add user: ${addedUserResult.message}");
    }
  } catch (e) {
    String errorMsg = "Error in Catch Block: ${e.toString()}";
    print("Error: $errorMsg");
    Fluttertoast.showToast(
      msg: errorMsg,
      backgroundColor: Colors.red,
    );
  }
}

Future<void> updateNewUser({
  required String id,
  required String name,
  required String stdClass,
  required String gender,
  required String age,
  required String address,
  required String image, // Ensure this is the correct file path to the image
}) async {
  try {
    String base64Image;

    // Check if the image is from the assets folder
    if (image.startsWith('assets/')) {
      // Load image from assets
      ByteData byteData = await rootBundle.load(image); // e.g., 'assets/images/logo.jpg'
      List<int> imageBytes = byteData.buffer.asUint8List();
      base64Image = base64Encode(imageBytes);
      print("Asset base64Image: $base64Image");
    } else {
      // Load image from file
      File file = File(image);

      if (!await file.exists()) {
        print("File not found at path: $image");
        Fluttertoast.showToast(
          msg: "Image file not found!",
          backgroundColor: Colors.red,
        );
        return;
      }

      // Read image bytes
      List<int> imageBytes = await file.readAsBytes();

      // Convert the image bytes to a Base64 string
      base64Image = base64Encode(imageBytes);
      print("File base64Image: $base64Image");
    }

    // Sending data to the repository
    CommonResponse updatedUserResult = await _homeRepository.updateUserData(
      id,
      name,
      stdClass,
      gender,
      age,
      address,
      base64Image,
    );

    // Handling the response
    if (updatedUserResult.status == true) {
      Fluttertoast.showToast(
        msg: updatedUserResult.message,
        backgroundColor: Colors.green,
      );
      print("User Updated successfully: ${updatedUserResult.message}");
      // Resetting the image file to force a refresh
    clearTextFields(); // Optional: Clear the text fields if needed
    Get.back(); //Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: updatedUserResult.message,
        backgroundColor: Colors.grey,
      );
      print("Failed to add user: ${updatedUserResult.message}");
    }
  } catch (e) {
    String errorMsg = "Error in Catch Block: ${e.toString()}";
    print("Error: $errorMsg");
    Fluttertoast.showToast(
      msg: errorMsg,
      backgroundColor: Colors.red,
    );
  }
}


Future<void> fetchUsers() async {
  print("refrsshig");
  try {
    // Fetch the user data stream from Firebase
    userStream = await DatabaseMethods().getUserData();

    // Clear the previous list of image files before populating new ones
    userImageFiles.clear();

    // Listen to the userStream and update the observable list
    userStream!.listen((QuerySnapshot snapshot) async {
      users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
     for (var user in users.value) {
  print('Id: ${user['Id']}');
  //print('Image: ${user['Image']}');
  print('-------------------------'); // Separator for clarity
}
    });
  } catch (e) {
    print("Error fetching users: $e");
  }
}




 void updateIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> pickImage() async {
  final picker = ImagePicker();
  
  // Try to pick an image from the gallery
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Log the file path to verify image selection
    print('Picked image path: ${pickedFile.path}');

    // Set the picked image to the reactive variable
    imageFile.value = File(pickedFile.path);
  } else {
    print('No image selected');
  }
}
    // Method to clear text fields
  void clearTextFields() {
    nameController.clear();
    classController.clear();
    genderController.clear();
    ageController.clear();
    addressController.clear();
    imageFile.value = null; // Optionally clear the image file as well
  }

@override
  void onClose() {
    super.onClose();
  }
}