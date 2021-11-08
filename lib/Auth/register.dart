import 'package:app/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthController auth = Get.put(AuthController());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // final _text = TextEditingController();
  final _user = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool obscure = true;
  // bool _validate = false;
  bool _isHidden = true;
  bool _isHidden1 = true;

  @override
  void dispose() {
    _user.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

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
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8)),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 70, color: Colors.white),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      prefixIcon: const Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      controller: _nameController,
                      validator: RequiredValidator(errorText: "Required"),
                      labelText: "Name",
                      hintText: "Your Full Name",
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyTextFormField(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      controller: _emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(
                            errorText: "Please enter a valid email address"),
                      ]),
                      labelText: "E-mail",
                      hintText: "Your E-mail",
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyTextFormField(
                      prefixIcon: const Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      obscureText: _isHidden,
                      controller: _passwordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                      ]),
                      labelText: "Password",
                      hintText: "Your Password",
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ), //toggle button
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyTextFormField(
                      prefixIcon: const Icon(
                        Icons.repeat_rounded,
                        color: Colors.white,
                      ),
                      obscureText: _isHidden1,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Required";
                        }
                        return MatchValidator(
                                errorText: "Passwords don't match")
                            .validateMatch(val, _passwordController.text);
                      },
                      labelText: "Re-type Password",
                      hintText: "Re-type Again",
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordView1,
                        child: Icon(
                          _isHidden1 ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ), //toggle button
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        child: const Text("Confirm"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // ignore: avoid_print
                            print(_nameController.text);
                            // ignore: avoid_print
                            print(_emailController.text);
                            // ignore: avoid_print
                            print(_passwordController.text);

                            // Add User first then nagivate to next page
                            // Can show loading while waiting, but usually very fast so not showing also
                            auth.register(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text);
                          }
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
                      height: 20.0,
                    ),
                    Wrap(
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/login");
                            }),
                      ],
                    ),
                  ],
                ))
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

  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }
}

class MyTextFormField extends StatefulWidget {
  MyTextFormField(
      {Key? key, //This line is a must
      this.controller,
      required this.validator, //required means
      required this.labelText,
      required this.hintText,
      this.prefixIcon,
      this.obscureText,
      this.suffixIcon})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String labelText;
  final String hintText;

  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;

  @override
  _MyTextFormField createState() => _MyTextFormField();
}

class _MyTextFormField extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,
      controller: widget.controller ?? null,
      validator: widget.validator,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 1.0),
          ),
          suffixIcon: widget.suffixIcon ?? null),
    );
  }
}
