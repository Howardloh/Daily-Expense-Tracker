import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:app/Model/event.dart';
import 'package:app/Calendar/calender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Controller/user_controller.dart';

class ExpenseList extends StatefulWidget {
  ExpenseList({Key? key, required this.setFunction}) : super(key: key);
  final void Function(String? selected) setFunction;

  @override
  _ExpenseList createState() => _ExpenseList();
}

class _ExpenseList extends State<ExpenseList> {
  String choice1 = "Workout";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(90, 70, 0, 0),
            ),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Workout");

                setState(() {
                  choice1 = 'Workout';
                });
              },
              child: const Text(" Workout"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Workout" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Workout"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Transport");
                setState(() {
                  choice1 = 'Transport';
                });
              },
              child: const Text("Transport"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Transport" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Transport"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(90, 70, 0, 0)),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Family");
                setState(() {
                  choice1 = 'Family';
                });
              },
              child: const Text("  Family  "),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Family" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Family"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Groceries");
                setState(() {
                  choice1 = 'Groceries';
                });
              },
              child: const Text("Groceries"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Groceries" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Groceries"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(90, 70, 0, 0)),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Gifts");
                setState(() {
                  choice1 = 'Gifts';
                });
              },
              child: const Text("    Gifts    "),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Gifts" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Gifts"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Others");
                setState(() {
                  choice1 = 'Others';
                });
              },
              child: const Text("  Others  "),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice1 == "Others" ? HexColor("#50B900") : Colors.white,
                side: choice1 == "Others"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IncomeList extends StatefulWidget {
  IncomeList({Key? key, required this.setFunction}) : super(key: key);
  final void Function(String?) setFunction;
  @override
  _IncomeList createState() => _IncomeList();
}

class _IncomeList extends State<IncomeList> {
  String choice2 = 'Interest';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(90, 70, 0, 0),
            ),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Interest");
                setState(() {
                  choice2 = 'Interest';
                });
              },
              child: const Text(" Interest"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice2 == "Interest" ? HexColor("#50B900") : Colors.white,
                side: choice2 == "Interest"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Gift");
                setState(() {
                  choice2 = 'Gift';
                });
              },
              child: const Text("Gift"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary: choice2 == "Gift" ? HexColor("#50B900") : Colors.white,
                side: choice2 == "Gift"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(90, 70, 0, 0)),
            ElevatedButton(
              onPressed: () {
                widget.setFunction("Other");
                setState(() {
                  choice2 = 'Other';
                });
              },
              child: const Text("  Other  "),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.black,
                primary:
                    choice2 == "Other" ? HexColor("#50B900") : Colors.white,
                side: choice2 == "Other"
                    ? BorderSide(color: HexColor("#00FF80"), width: 1)
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 70),
      ],
    );
  }
}

class TransacTion extends StatefulWidget {
  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<TransacTion> {
  TextEditingController _amountController = TextEditingController();
  String choice = 'Expense';
  String category = "Workout";
  UserController user = Get.find();
  @override
  void dispose() {
    // myController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void getCategory(selected) {
    category = selected;
  }

  Future<void> addTransaction() async {
    await user.addTransaction(
        choice, category, double.parse(_amountController.text));
    print(_amountController.text);
    print(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Transaction',
          ),
          backgroundColor: HexColor("#831483"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/calendar");
            },
          )),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(children: <Widget>[
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(90, 70, 0, 0)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    choice = "Expense";
                  });
                },
                child: const Text("Expense"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: choice == "Expense"
                      ? HexColor("#50B900")
                      : Colors.grey[400],
                  side: choice == "Expense"
                      ? BorderSide(color: HexColor("#00FF80"), width: 1)
                      : null,
                ),
              ),
              const SizedBox(width: 50),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    choice = "Income";
                  });
                },
                child: const Text("Income"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: choice == "Income"
                      ? HexColor("#50B900")
                      : Colors.grey[400],
                  side: choice == "Income"
                      ? BorderSide(color: HexColor("#00FF80"), width: 1)
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
            child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                controller: _amountController,
                keyboardType: TextInputType.number),
          ),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 300, 10),
            child: const Text(
              "Categories",
              style: TextStyle(color: Colors.white),
            ),
          ),
          (() {
            if (choice == 'Expense') {
              return ExpenseList(setFunction: getCategory);
            } else {
              return IncomeList(setFunction: getCategory);
            }
          }()),
          const SizedBox(height: 40),
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(140, 0, 0, 0)),
              ElevatedButton(
                onPressed: () async {
                  if (user.status == "Edit") {
                    await addTransaction();
                    user.deleteTransaction(user.editingID.toString());
                  } else {
                    await addTransaction();
                  }
                },
                child: const Text(
                  "   Add   ",
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: HexColor("#F7B83B"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(140, 0, 0, 0)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/calendar");
                },
                child: const Text(
                  " Cancel",
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: HexColor("#F7B83B"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
