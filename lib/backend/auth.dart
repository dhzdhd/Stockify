import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  var toContent;
  var fireStore = FirebaseFirestore.instance.collection('/users');

  Auth(this.toContent);

  void storeData() {}
}
