import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final auth = FirebaseAuth.instance;
  final CollectionReference user = FirebaseFirestore.instance.collection(
    'users',
  );
}
