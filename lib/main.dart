import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_chat/screens/chat_screen.dart';
import 'package:u_chat/screens/login_screen.dart';
import 'package:u_chat/screens/registration_screen.dart';
import 'package:u_chat/screens/welcome_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UChat());
}

class UChat extends StatelessWidget {
  const UChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
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
