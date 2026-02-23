import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/repository/Exceptions/auth_exceptions.dart';
import 'package:nike_shoes_app/repository/auth_repository.dart';
import 'package:nike_shoes_app/utilities/utilis.dart';
import 'package:nike_shoes_app/view/admin_panel_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository authRepo = AuthRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<UserCredential> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final uCredentials = await authRepo.loginUserWithEmailAndPassword(
        email,
        password,
      );
      _isLoading = false;
      notifyListeners();
      return uCredentials;
    } on AuthExceptions catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserCredential> createUser(String email, String password, name) async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await authRepo.signUpWithEmailAndPassword(
        email,
        password,
        name,
      );
      _isLoading = false;
      notifyListeners();
      return user;
    } on AuthExceptions catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepo.logoutUser();
    notifyListeners();
  }
}
