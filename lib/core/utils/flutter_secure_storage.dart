import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage

  final storage = const FlutterSecureStorage();

  final String _userName = 'userName';
  final String _userRole = 'userRole';
  final String _userId = 'userId';
 
  // Remove methods

  Future removeAll() async {
    print("removeAll");
    final keysToEliminate = [
      _userName,
      _userRole,
      _userId,
      
    ];

    await Future.wait(keysToEliminate.map((key) => storage.delete(key: key)));
  }

  Future removeUserId() async {
    storage.delete(key: _userId);
  }

  Future removeUserRole() async {
    storage.delete(key: _userRole);
  }

  Future removeUserName() async {
    storage.delete(key: _userName);
  }

  // Set methods

  Future setUserName(String userName) async {
    await storage.write(key: _userName, value: userName);
  }

  Future setUserId(String userId) async {
    await storage.write(key: _userId, value: userId);
  }

  Future setUserRole(String userRole) async {
    await storage.write(key: _userRole, value: userRole);
  }

  // Get methods

  Future<String?> getUserName() async {
    return await storage.read(key: _userName);
  }

  Future<String?> getUserId() async {
    return await storage.read(key: _userId);
  }

  Future<String?> getUserRole() async {
    return await storage.read(key: _userRole);
  }

}
