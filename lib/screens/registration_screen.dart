import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:u_chat/screens/chat_screen.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isObscure = true;
  final loginKey = GlobalKey<FormState>();
  static String id = 'login_screen';
  final _auth=FirebaseAuth.instance;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: "logo",
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 200,
              ),
            ),
            SizedBox(height: 48),
            Form(
              key: loginKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    onChanged: (value){
                      email=value;

                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is Empty";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "enter your correct email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 1.0,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    obscureText: _isObscure,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password=value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: 'Enter your password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        splashColor: Colors.white,
                        onPressed: () async {
                          if (loginKey.currentState!.validate()) {
                           final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                           Navigator.pushNamed(context, ChatScreen.id);
                          }

                          //Implement login functionality.
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account? ",
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 20.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, LoginScreen.id))
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
