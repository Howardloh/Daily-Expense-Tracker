import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Calendar/calender.dart';
import 'dart:async';

void main() => runApp(GetMaterialApp(home: MainPage()));

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                height: 200,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '“Small amounts saved daily add up to huge investments in the end.” – Margo Vader',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    TypewriterAnimatedText(
                      '“Not wasting money is the best way to save money.” – Mokokoma Mokhonoana',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    TypewriterAnimatedText(
                      '“Balancing your money is the key to having enough” – Elizabeth Warren',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    TypewriterAnimatedText(
                      '“Saving requires us to not get things now so that we can get bigger ones later.” – Jean Chatzky',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    TypewriterAnimatedText(
                      '“Beware of little expenses. A small leak will sink a great ship.” – Benjamin Franklin',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    TypewriterAnimatedText(
                      ' “Stop buying things you don’t need to impress people you don’t even like.” – Suze Orman',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ],
                  repeatForever: true,
                  displayFullTextOnTap: true,
                ),
              ),
              Center(
                child: MyBlinkingButton(),
              ),
            ],
          )),
    );
  }
}

class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isBluetoothOn = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IconButton(
        iconSize: 105.0,
        icon: const Icon(
          Icons.account_balance_wallet,
          color: Colors.white,
        ),
        onPressed: () {
          Get.offAll(() => Calendar());
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
