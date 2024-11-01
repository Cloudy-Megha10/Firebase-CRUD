import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserData(Map<String, dynamic> userdata, String id) async {
    print("userdata $userdata id $id");
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userdata);
  }

  Future<Stream<QuerySnapshot>> getUserData() async {
    print("QuerySnapshot $QuerySnapshot");
    return await FirebaseFirestore.instance.collection('Users').snapshots();
  }

  Future updateUserData(String id, Map<String, dynamic> updatedUserData) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .update(updatedUserData);
  }

  Future deleteUserData(String id) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .delete();
  }
}
