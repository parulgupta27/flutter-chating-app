import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:chat_off/screens/welcome.dart';
import 'package:chat_off/screens/login_screen.dart';
import 'package:chat_off/screens/registration_screen.dart';
import 'package:chat_off/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(FlashChat());
} 

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: '/',
      routes: 
      {
        '/':(context) => HomeScreen(),
        '/login':(context) => LoginScreen(),
        '/register':(context) => RegistrationScreen(),
        '/chat':(context) => ChatScreen(),
      },
    );
  }
}

