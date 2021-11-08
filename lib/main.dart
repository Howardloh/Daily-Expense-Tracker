import 'package:app/Calendar/calender.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:app/Auth/login.dart';
import 'package:app/Auth/register.dart';
import 'package:app/generate_chart.dart';
import 'package:app/Calendar/transaction.dart';
import 'package:app/currency.dart';
import 'package:app/profile.dart';
import 'package:app/mainpage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      //Navigation route
      routes: {
        '/': (context) => Main(),
        '/login': (context) => Login(),
        '/signup': (context) => Register(),
        '/calendar': (context) => Calendar(),
        '/transaction': (context) => TransacTion(),
        '/currency': (context) => Currency(),
        '/profile': (context) => Profile(),
        '/chart': (context) => GeneratePieChart(),
        '/mainpage1': (context) => MainPage(),
      },
    ),
  );
}

class Main extends StatefulWidget {
  @override
  _Main createState() => _Main();
}

class _Main extends State<Main> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return SomethingWentWrong();
    }
    if (!_initialized) {
      return Loading();
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(400, 100, 0, 0)),
            Image.asset('assets/Logo.png', scale: 1.5),
            const SizedBox(height: 30),
            const Text("Daily Expense Tracker",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 70.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.57,
              child: ElevatedButton(
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                style: ElevatedButton.styleFrom(
                  // returns ButtonStyle
                  primary: HexColor("#F7B83B"),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.57,
              child: ElevatedButton(
                child: const Text("Login", style: TextStyle(fontSize: 30)),
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                style: ElevatedButton.styleFrom(
                  // returns ButtonStyle
                  primary: HexColor("#F7B83B"),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatefulWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  _SomethingWentWrongState createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Something Went Wrong"),
      content: const Text("Please Try Again"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: const Text("Try Again")),
      ],
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
