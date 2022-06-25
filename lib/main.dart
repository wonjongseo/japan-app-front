import 'package:flutter/material.dart';
import 'package:japan_front/screen/KangiJlptLevel.dart';
import 'package:japan_front/screen/home.dart';
import 'package:japan_front/screen/JLPT.dart';

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
        "/kangis/level/N1": (context) => KangiJlptLevel(level: 1),
        // "/kangis/level/N1/step": (context) => KangiLevel(level: 1),
        "/kangis/level/N2": (context) => KangiJlptLevel(level: 2),
        "/kangis/level/N3": (context) => KangiJlptLevel(level: 3),
        "/kangis/level/N4": (context) => KangiJlptLevel(level: 4),
        "/kangis/level/N5": (context) => KangiJlptLevel(level: 5),
        // "/kangi": null,
      },
    );
  }
}
