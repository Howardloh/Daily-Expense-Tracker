import 'package:flutter/foundation.dart';

class Event {
  String id = "";
  String title = '';
  String type = '';
  double amount = 0.0;
  Event(
      {required this.id,
      required this.title,
      required this.amount,
      required this.type});

  String toString() => this.title;
}
