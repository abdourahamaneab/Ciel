import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ciel/screens/Home.dart';
import 'package:ciel/screens/affiche.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ciel',
      home: ProgressPage(),
      // dans la cronologie des ecrans de home on doit pouvoit aller a

    );
  }
}
