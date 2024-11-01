import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/data/apiClient/common_response.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:demo_app/presentation/home_screen/controller/home_repository.dart';
import 'package:demo_app/presentation/home_screen/models/user_fields.dart';
import 'package:demo_app/presentation/home_screen/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  HomeRepository _homeRepository = HomeRepository();
  UserModel userModelObj = UserModel();
  var selectedIndex = 2.obs;
  Stream<QuerySnapshot>? userStream;
  var imageFile = Rxn<File>();
  Rxn<Uint8List> imageBytes =
      Rxn<Uint8List>(); // Store the Base64-decoded image bytes

  @override
  void onReady() async {
    super.onReady();
    fetchUsers();
  }

  void decodeBase64Images(List<String> base64Strings) {
    try {
      // Decode each base64 string and concatenate into a single Uint8List
      List<int> allBytes = [];
      for (var base64String in base64Strings) {
        final decodedBytes = base64Decode(base64String);
        allBytes.addAll(decodedBytes); // Append to the list
      }
      imageBytes.value = Uint8List.fromList(allBytes); // Convert to Uint8List
    } catch (e) {
      print("Error decoding base64 images: $e");
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
        ByteData byteData =
            await rootBundle.load(image); // e.g., 'assets/images/logo.jpg'
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
        //userModelObj.usersList.clear();
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
        ByteData byteData =
            await rootBundle.load(image); // e.g., 'assets/images/logo.jpg'
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
        //userModelObj.usersList.clear();// Resetting the image file to force a refresh
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

  Future<void> decodeAndSaveImage(dynamic imageData) async {
    try {
      Uint8List decodedBytes;

      // Check if imageData is a base64 string or already a Uint8List
      if (imageData is String && imageData.isNotEmpty) {
        decodedBytes = base64Decode(imageData);
      } else if (imageData is Uint8List) {
        decodedBytes = imageData;
      } else {
        throw Exception("Invalid image data format");
      }

      // Write to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
          '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(decodedBytes);

      // Update the observable with the file
      imageFile.value = tempFile;
      print("File created at: ${tempFile.path}");
    } catch (e) {
      print("Error decoding and saving image: $e");
      imageFile.value = null;
    }
  }

  Future<void> fetchUsers() async {
    print("refrsshig");
    try {
      // Fetch the user data stream from Firebase
      userStream = await DatabaseMethods().getUserData();

      // Clear the previous list of image files before populating new ones
      userModelObj.usersList.clear();
      // Listen to the userStream and update the observable list
      userStream!.listen((QuerySnapshot snapshot) async {
        // Convert snapshot data to a list of documents (mocked here as getAllUserResult.Data.data)
        var getAllUserResult = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        // Assuming getAllUserResult.Data.data is accessible in a similar way
        for (var getAllUserList in getAllUserResult) {
          // Create an instance of UserManagementItemModel with the formatted data
          UserFieldsModel userModel = UserFieldsModel(
              id: getAllUserList['Id'],
              name: getAllUserList['Name'],
              className: getAllUserList['Class'],
              gender: getAllUserList['Gender'].toString(),
              age: getAllUserList['Age'],
              address: getAllUserList['Address'].toString(),
              images: base64Decode(getAllUserList['Image']));

          // Add the created model to the usersList
          userModelObj.usersList.add(userModel);
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
