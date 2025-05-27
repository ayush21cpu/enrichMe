import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class LoginViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<User?> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final user = await AuthService().login(email, password);

      if (user == null) {
        _error = 'Invalid credentials';
      }

      return user;
    } catch (e) {
      _error = 'Something went wrong';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
