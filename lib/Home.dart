import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 120,
          width: 100,
          child: Text("Hello Kese Hai app sab chalo shuru krte hai bina kisi bakchodi ke AA Jo AA SAB JLDI HO JAYE GLTI")),
      ),
    );
  }
}