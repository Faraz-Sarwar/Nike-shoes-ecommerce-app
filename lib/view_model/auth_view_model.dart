import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike_shoes_app/repository/Exceptions/auth_exceptions.dart';
import 'package:nike_shoes_app/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository authRepo = AuthRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<UserCredential> login(String email, String password) async {
    isLoading = true;
    try {
      final uCredentials = await authRepo.loginUserWithEmailAndPassword(
        email,
        password,
      );
      return uCredentials;
    } on AuthExceptions catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  Future<UserCredential> createUser(String email, String password) async {
    isLoading = true;
    try {
      final user = await authRepo.signUpWithEmailAndPassword(email, password);
      return user;
    } on AuthExceptions catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}
