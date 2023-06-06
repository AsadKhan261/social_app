import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/infrastructure/models/user_model.dart';

class UserServices {

  Future createUser(BuildContext context,
      {required UserModel model, required String uid}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(uid);

    return await docRef.set(model.toJson(uid));
  }
}
