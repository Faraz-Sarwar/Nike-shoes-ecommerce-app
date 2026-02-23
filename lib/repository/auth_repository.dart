import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_shoes_app/repository/Exceptions/auth_exceptions.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<UserCredential> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credentials;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthExceptions('User not found for that email.');
      } else if (e.code == "wrong-password") {
        throw AuthExceptions('Incorrect password, Try again.');
      } else {
        throw AuthExceptions(e.message ?? "An unknown error occured");
      }
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await users.doc(credentials.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'user',
      });
      return credentials;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthExceptions(
          'User with this email already exists, try a diffrent email.',
        );
      } else if (e.code == 'user-not-found') {
        throw AuthExceptions('User not found for that email.');
      } else if (e.code == 'invalid-email') {
        throw AuthExceptions(
          'Invalid email, please sign up with a valid email',
        );
      } else if (e.code == 'weak-password') {
        throw AuthExceptions(
          'Password is too weak, try some stronger password',
        );
      } else {
        throw AuthExceptions(
          e.message ?? "An error occured while signing up, try again later",
        );
      }
    }
  }

  Future<void> logoutUser() async {
    await auth.signOut();
  }
}
