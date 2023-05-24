import 'package:ciel/main.dart';
import 'package:flutter/material.dart';
import 'package:ciel/screens/affiche.dart';
import 'package:ciel/screens/Home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress App',
      home: Home(),
    );
  }
}


