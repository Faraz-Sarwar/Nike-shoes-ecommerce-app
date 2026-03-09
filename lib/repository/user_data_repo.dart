import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataRepo {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future<bool> isAdminAccessAllowed() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return doc.data()?['role'] == 'admin';
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return doc.data();
  }

  Future<void> saveProfileInfo({
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    await FirebaseFirestore.instance.collection('userInfo').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
    });
  }
}
