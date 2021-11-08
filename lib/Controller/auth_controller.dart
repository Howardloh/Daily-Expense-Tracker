import 'package:app/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/Calendar/calender.dart';
import 'package:app/mainpage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      //Register User into database
      users
          .doc(_auth.currentUser!.uid)
          .set({
            'name': name,
            'email': email,
            'password': password,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      Get.offAll(() => MainPage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString());
    } catch (e) {
      Get.snackbar("Other Error", e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.offAll(() => MainPage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.message.toString());
    }
  }
}
