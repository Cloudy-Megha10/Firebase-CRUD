import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
    String base64Image = '';
    dynamic convertedImage;
     Uint8List bytes = Uint8List(0); // Creates an empty Uint8List
    var imageBytes = Rxn<Uint8List>(); // Store the Base64-decoded image bytes

@override
void onReady() async{
  super.onReady();
  fetchUsers();
  //listenToUserStream();
}

// Future<void> setImageFromBase64(String base64Image) async {
//   try {
//     List<int> imageBytes = base64Decode(base64Image);
//     final directory = await getTemporaryDirectory();

//     // Create a unique file name for the image
//     final fileName = '${DateTime.now().millisecondsSinceEpoch}_image.jpg';
//     final file = File('${directory.path}/$fileName');

//     // Optional: Remove old image file if it exists
//     if (await file.exists()) {
//       await file.delete();
//     }

//     // Write the new image bytes to the file
//     await file.writeAsBytes(imageBytes);

//     // Update the controller's imageFile
//     imageFile.value = file; // This should trigger an update in the UI

//     print("Image successfully decoded and saved to file: ${file.path}");
//     print("Decoded image bytes length: ${imageBytes.length}"); // Debugging statement
//   } catch (e) {
//     print("Error while setting image from base64: $e");
//     Fluttertoast.showToast(
//       msg: "Error loading image",
//       backgroundColor: Colors.red,
//     );
//   }
// }



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
    Get.back();
            //Navigator.pop(context);
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
  try {
    // Fetch the user data stream from Firebase
    userStream = await DatabaseMethods().getUserData();

    // Clear the previous list of image files before populating new ones
    userImageFiles.clear();

    // Listen to the userStream and update the observable list
    userStream!.listen((QuerySnapshot snapshot) async {
      users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      for (var user in users.value) {
        if (user.containsKey('Image') && user['Image'].isNotEmpty) {
          String base64String = user['Image'].split(',').last;

          try {
            // Decode the base64 string into bytes
            Uint8List bytes = base64Decode(base64String);

            // Optionally save the image as a file for display using Image.file()
            final tempDir = await getTemporaryDirectory();
            final tempFile = File('${tempDir.path}/${user['userId']}_image.png');
            await tempFile.writeAsBytes(bytes);

            // Add the decoded image file to the observable list
            userImageFiles.add(tempFile);
            print('Decoded image file for user: ${user['userId']}');
          } catch (e) {
            print('Error decoding image for user ${user['userId']}: $e');
          }
        } else {
          // If no image is available, add a placeholder (optional)
          userImageFiles.add(File(''));  // Add empty file or placeholder
        }
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