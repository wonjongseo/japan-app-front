import 'package:flutter/material.dart';
import 'package:japan_front/screen/home.dart';
import 'package:japan_front/screen/jlpt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/kangis/level/N1": (context) => JLPT(level: 1),
        "/kangis/level/N2": (context) => JLPT(level: 2),
        "/kangis/level/N3": (context) => JLPT(level: 3),
        "/kangis/level/N4": (context) => JLPT(level: 4),
        "/kangis/level/N5": (context) => JLPT(level: 5),
        // "/kangi": null,
      },
    );
  }
}
