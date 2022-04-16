import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:u_chat/screens/chat_screen.dart';
import 'package:u_chat/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final loginKey = GlobalKey<FormState>();
  static String id = 'login_screen';
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  late String Email;
  late String Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 200,
                  ),
                ),
                const SizedBox(height: 48),
                Form(
                  key: loginKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          Email = value;
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
                        decoration: const InputDecoration(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
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
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: _isObscure,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          Password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your password";
                          } else if (value.length <= 6) {
                            return "length of password should be greater than 6";
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            splashColor: Colors.white,
                            onPressed: () async {
                              if (loginKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: Email, password: Password);
                                if (user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("user not found")));
                                }
                               else if(user!=null){
                                Navigator.pushNamed(context, ChatScreen.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }},
                            minWidth: 200.0,
                            height: 42.0,
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                          TextSpan(
                              text: "Register",
                              style: const TextStyle(
                                  color: Colors.blueAccent, fontSize: 20.0),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, RegistrationScreen.id))
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
