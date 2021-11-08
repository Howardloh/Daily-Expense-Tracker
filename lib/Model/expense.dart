import 'package:flutter/foundation.dart';

@immutable
class Expense {
  Expense({
    required this.amount,
    required this.category,
    required this.date,
  });

  Expense.fromJson(Map<String, Object?> json)
      : this(
            amount: json['amount']! as int,
            category: json['category']! as String,
            date: json["date"]! as DateTime);

  final int amount;
  final String category;
  final DateTime date;

  Map<String, Object?> toJson() {
    return {'amount': amount, 'category': category, 'date': date};
  }
}
