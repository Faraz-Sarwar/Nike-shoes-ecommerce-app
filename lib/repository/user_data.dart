import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final auth = FirebaseAuth.instance;
  final CollectionReference user = FirebaseFirestore.instance.collection(
    'users',
  );

  Widget getUserName({String prefixText = ''}) {
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(auth.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('${prefixText}User');
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('$prefixText${data['name']}');
      },
    );
  }

  Widget getUserEmail() {
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(auth.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User');
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Text(data['email']);
      },
    );
  }
}
