import 'package:app/Controller/event_controller.dart';
import 'package:app/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/Calendar/calender.dart';
import "dart:convert";

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  EventController event = Get.put(EventController());
  Future<User> get getAuthUser async => _auth.currentUser!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String status = "none";
  String editingID = "";
  final name = "".obs;
  final email = "".obs;

  void getUser() {
    firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((documentSnapshot) {
      final data = UserModel.fromMap(documentSnapshot.data()!);
      name.value = data.name;
      email.value = data.email;
    });
  }

  Future<void> addTransaction(
      String type, String category, double amount) async {
    CollectionReference transaction = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection("transaction");
    //add into firestore
    await transaction.add({
      "type": type,
      "category": category,
      "amount": amount,
      "date": Timestamp.now(),
    } //to show snackbar
        ).whenComplete(() {
      event.updateSelectedEvents();

      if (status != "Edit") {
        Get.snackbar("Success", "Event Added successfully");
      }
    }).catchError((e) {
      Get.snackbar("Firebase Error", e.message.toString());
    });
  }

  Future<void> deleteTransaction(String id) async {
    DocumentReference transaction = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection("transaction")
        .doc(id);
    //add into firestore
    await transaction.delete().whenComplete(() {
      event.updateSelectedEvents();
      if (status.toString() == "Edit") {
        Get.snackbar("Success", "Event Edit successfully");
      } else {
        Get.snackbar("Success", "Event Deleted successfully");
      }
    }).catchError((e) {
      Get.snackbar("Firebase Error", e.message.toString());
    });
  }

  Future<void> deleteSavings(String id) async {
    CollectionReference transaction = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection("transaction");

    transaction.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
