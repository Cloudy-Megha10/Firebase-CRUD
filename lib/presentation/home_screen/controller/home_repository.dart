

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/data/apiClient/common_response.dart';
import 'package:demo_app/firebase_database/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeRepository {
 Future<CommonResponse<dynamic>> addUserData(
    String id,
    String? name,
    String? stdClass,
    String? gender,
    String? age,
    String? address,
    String? image) async {
  try {
    // Logging for debugging
    print("Adding user data for name: $name");

    // Creating the user data map
    Map<String, dynamic> userData = {
      "Name": name,
      "Class": stdClass,
      "Id": id,
      "Gender": gender,
      "Age": age,
      "Address": address,
      "Image": image, // Assuming image is a base64 string
    };

    // Adding data to Firebase Firestore (assuming "users" collection)
    await DatabaseMethods().addUserData(userData, id).then((value){
                     Fluttertoast.showToast(
        msg:'Data Saved Successfully',textColor:  Colors.green);
                  });

    print("User data added successfully");

    // Wrapping response in CommonResponse
    return CommonResponse(true, userData, "User data added successfully");
  } on FirebaseException catch (e) {
    print("Firebase Error: $e");
    return CommonResponse.withoutData(false, "Firebase Error: ${e.message}");
  } catch (e) {
    print("Error in Catch Block: $e");
    return CommonResponse.withoutData(false, "Failure: $e");
  }
}

Future<CommonResponse<dynamic>> updateUserData(
    String id,
    String? name,
    String? stdClass,
    String? gender,
    String? age,
    String? address,
    String? image) async {
  try {
    // Logging for debugging
    print("Update user data for name: $name");

    // Creating the user data map
    Map<String, dynamic> userData = {
      "Name": name,
      "Class": stdClass,
      "Id": id,
      "Gender": gender,
      "Age": age,
      "Address": address,
      "Image": image, // Assuming image is a base64 string
    };
    print("id$id");

    // // Adding data to Firebase Firestore (assuming "users" collection)
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(id)
    //     .update(userData);
     await DatabaseMethods().updateUserData(id, userData).then((value) {
    // Once updated, refresh the user list to reflect the changes
    Fluttertoast.showToast(msg: 'Data Updated Successfully', textColor: Colors.green);
     });
 
    print("User data updated successfully");

    // Wrapping response in CommonResponse
    return CommonResponse(true, userData, "User data updated successfully");
  } on FirebaseException catch (e) {
    print("Firebase Error: $e");
    return CommonResponse.withoutData(false, "Firebase Error: ${e.message}");
  } catch (e) {
    print("Error in Catch Block: $e");
    return CommonResponse.withoutData(false, "Failure: $e");
  }
}

}