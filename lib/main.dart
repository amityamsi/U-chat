import 'package:flutter/material.dart';
import 'package:u_chat/screens/chat_screen.dart';
import 'package:u_chat/screens/login_screen.dart';
import 'package:u_chat/screens/registration_screen.dart';
import 'package:u_chat/screens/welcome_screen.dart';

void main() {
  runApp(UChat());
}

class UChat extends StatelessWidget {
  const UChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.light().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
