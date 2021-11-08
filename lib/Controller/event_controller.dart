import 'package:app/Controller/user_controller.dart';
import 'package:app/Model/event.dart';
import 'package:app/Model/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/Calendar/calender.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  final selectedEvents = <String, List<Event>>{}.obs;
  List<Expense> expenseList = <Expense>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final saving = 0.0.obs;
  final chartIncome = 0.0.obs;
  final chartExpense = 0.0.obs;
  final total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateSelectedEvents() {
    final userID = _auth.currentUser!.uid;
    selectedEvents.clear();
    saving.value = 0.0;
    firestore
        .collection("users")
        .doc(userID)
        .collection("transaction")
        .snapshots()
        .listen((result) {
      //do looping the transaction in firestore. To ensure get all the data in transaction
      result.docs.forEach((doc) {
        // {amount: 0, category: "Transport", date: "20/07/2021", type: "Expense"}
        print(doc);

        //print the selected date in the debug console
        print(doc["date"].toDate());

        //print the amount and category in the debug console
        print(doc["amount"]);
        print("Category :  " + doc["category"]);

        final List<Event> eventList = <Event>[];

        if (doc["type"] == "Expense") {
          saving.value -= doc["amount"];
        } else {
          saving.value += doc["amount"];
          chartIncome.value += doc["amount"];
        }

        //change the date format and store it in the date
        DateFormat _dateformat = DateFormat("y-MM-d");
        String date = _dateformat.format(doc["date"].toDate());

        //check wheter the selected date have in the firestore, if have return the event to the app
        if (selectedEvents.containsKey(date)) {
          //date - function key
          //previousEventList - parameter
          selectedEvents.update(date, (previousEventList) {
            double amount = doc["amount"];
            previousEventList.add(Event(
                id: doc.id,
                title: doc["category"],
                amount: amount,
                type: doc["type"]));
            return previousEventList;
          });
        } else {
          double amount = doc["amount"];
          eventList.add(Event(
              id: doc.id,
              title: doc["category"],
              amount: amount,
              type: doc["type"]));
          selectedEvents.putIfAbsent(date, () => eventList);
        }
      });
    });
  }

  void getTodayChart() {
    chartExpense.value = 0.0;
    chartIncome.value = 0.0;
    total.value = 0.0;
    print("START : GET TODAY CHART");
    DateFormat _dateformat = DateFormat("y-MM-d");
    var now = new DateTime.now();
    String date = _dateformat.format(now);
    if (selectedEvents.containsKey(date)) {
      List<Event> events = selectedEvents[date]!;
      for (var event in events) {
        if (event.type == "Expense") {
          print(event.amount);
          chartExpense.value += event.amount;
          total.value += event.amount;
        } else {
          print(event.amount);
          chartIncome.value += event.amount;
          total.value += event.amount;
        }
      }
    } else {
      print("NO SELECTED DAY");
      chartExpense.value = 0.0;
      chartIncome.value = 0.0;
      total.value = 0.0;
    }
    print("END : GET TODAY CHART");
  }

  void getMonthChart() {
    chartExpense.value = 0.0;
    chartIncome.value = 0.0;
    total.value = 0.0;
    print("START : GET Month CHART");
    DateFormat _dateformat = DateFormat("y-MM-d");
    var now = new DateTime.now();
    String date = _dateformat.format(now);
    if (selectedEvents.containsKey(date)) {
      List<Event> events = selectedEvents[date]!;
      for (var event in events) {
        if (event.type == "Expense") {
          print(event.amount);
          chartExpense.value += event.amount;
          total.value += event.amount;
        } else {
          print(event.amount);
          chartIncome.value += event.amount;
          total.value += event.amount;
        }
      }
    } else {
      print("NO SELECTED DAY");
      chartExpense.value = 0.0;
      chartIncome.value = 0.0;
      total.value = 0.0;
    }
    print("END : GET TODAY CHART");
  }

  void clearAmount() {
    final userID = _auth.currentUser!.uid;
    WriteBatch batch = FirebaseFirestore.instance.batch();

    firestore
        .collection("users")
        .doc(userID)
        .collection("transaction")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });

      batch.commit();
    });
    // updateSelectedEvents();
    saving.value = 0.0;
  }
}
