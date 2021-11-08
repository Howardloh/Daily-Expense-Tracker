import 'dart:math';

import 'package:app/Controller/event_controller.dart';
import 'package:app/Controller/user_controller.dart';
import 'package:app/Model/event.dart';
import 'package:app/Model/expense.dart';
import 'package:app/Model/argument_calendar.dart';
import 'package:app/Calendar/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // ignore: prefer_final_fields
  TextEditingController _eventController = TextEditingController();
  UserController user = Get.put(UserController());
  EventController events = Get.put(EventController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    print(_auth.currentUser!.uid);
    events.updateSelectedEvents();
    user.getUser();
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    DateFormat _dateformat = DateFormat("y-MM-d");
    String chosenDate = _dateformat.format(date);
    return events.selectedEvents[chosenDate] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/OIP.png'),
        backgroundColor: Colors.white,
      ),
      accountName: Obx(() => Text(user.name.value)),
      accountEmail: Obx(() => Text(user.email.value)),
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 131, 20, 131),
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 30.0,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/profile");
            }),
        ListTile(
            leading: const Icon(
              Icons.pie_chart,
              size: 30.0,
            ),
            title: const Text('Chart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/chart");
            }),
        ListTile(
            leading: const Icon(
              Icons.calculate,
              size: 30.0,
            ),
            title: const Text('Currency Converter'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/currency");
            })
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Daily Expense Tracker"),
        centerTitle: true,
        backgroundColor: HexColor("#831483"),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          //events
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => Slidable(
                actionPane: const SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  (() {
                    DateTime date = DateTime.now();
                    DateFormat _dateformat = DateFormat("y-MM-d");
                    String formatedDate = _dateformat.format(date);
                    String selectedDate = _dateformat.format(selectedDay);
                    if (formatedDate == selectedDate) {
                      return Row(children: <Widget>[
                        Container(
                          width: 48.5,
                          child: IconSlideAction(
                            caption: 'Edit',
                            color: Colors.yellow[600],
                            icon: Icons.edit,
                            onTap: () {
                              // user.deleteTransaction(event.id);
                              user.status = "Edit";
                              user.editingID = event.id;

                              Get.to(() => TransacTion());
                            },
                          ),
                        ),
                        Container(
                          width: 48.5,
                          child: IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              user.deleteTransaction(event.id);
                            },
                          ),
                        )
                      ]);
                    } else {
                      return Container();
                    }
                  }()),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          event.title,
                          style: (() {
                            if (event.type.toString() == "Expense") {
                              return const TextStyle(
                                  fontSize: 20, color: Colors.red);
                            } else {
                              return const TextStyle(
                                  fontSize: 20, color: Colors.green);
                            }
                          }()),
                        ),
                        Text(
                          (() {
                            if (event.type.toString() == "Expense") {
                              return "- RM " + event.amount.toString();
                            } else {
                              return "+ RM " + event.amount.toString();
                            }
                          }()),
                          style: (() {
                            if (event.type.toString() == "Expense") {
                              return const TextStyle(
                                  fontSize: 20, color: Colors.red);
                            } else {
                              return const TextStyle(
                                  fontSize: 20, color: Colors.green);
                            }
                          }()),
                        )
                      ]),
                )),
          ),
        ],
      ),
      //drawer
      drawer: Drawer(
        child: drawerItems,
      ),

      // Add Event
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: HexColor("#AEC0FC"),
        onPressed: () {
          Get.offAll(() => TransacTion());
        },
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
