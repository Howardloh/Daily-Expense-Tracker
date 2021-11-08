// import 'package:app/service/auth.dart';
import 'package:app/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:app/Model/argument_calendar.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  final AuthController auth = Get.put(AuthController());

  bool obscure = true;
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _messangerKey,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8)),
            const SizedBox(
              height: 80.0,
            ),
            Image.asset('assets/Logo.png',
                alignment: Alignment.center, width: 175, height: 175),
            const SizedBox(
              height: 70.0,
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(
                            errorText: "Please enter a valid email address"),
                      ]),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Your Email Address ",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      obscureText: _isHidden,
                      controller: _passwordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                      ]),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: "Your Password",
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ), //toggle button
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            auth.login(_emailController.text,
                                _passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("#F7B83B"),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Wrap(
                      children: [
                        const Text(
                          "Don't have acc? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                            child: const Text(
                              'Sign Up Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/signup");
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
