// auth_provider.dart

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? authToken;
  String? lastLogin;

  void setAuthToken(String? token) {
    authToken = token;
    notifyListeners();
  }

  void signOut() {
    authToken = null; 
    notifyListeners();
  }

  void setLastLogin(String? newLastLogin) {
    lastLogin = newLastLogin;
  }


  String? getLastLogin() {
    return lastLogin;
  }
}
