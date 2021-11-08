import 'package:app/Controller/event_controller.dart';
import 'package:app/Controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Profile> {
  UserController user = Get.find();
  EventController event = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        centerTitle: true,
        backgroundColor: HexColor("#831483"),
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'NAME',
                style: TextStyle(
                  color: HexColor("#E2D4D4"),
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ), //for adding space
              Obx(
                () => Text(
                  user.name.value,
                  style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'TOTAL SAVINGS',
                style: TextStyle(
                  color: HexColor("#E2D4D4"),
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "RM",
                style: TextStyle(color: Colors.amber[50]),
              ), //for adding space
              Obx(
                () => Text(
                  "    " + event.saving.value.toString() + "0",
                  style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    event.clearAmount();
                  },
                  child: const Text("Clear")),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Obx(() => Text(
                        user.email.value,
                        style: TextStyle(
                          color: Colors.amberAccent[200],
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 240.0),
              IconButton(
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                  size: 55,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
