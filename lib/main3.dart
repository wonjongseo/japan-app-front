import 'package:flutter/material.dart';
import 'package:japan_front/screen/grammer/GrammerLevel.dart';
import 'package:japan_front/screen/kangi/KangiJlptLevel.dart';
import 'package:japan_front/screen/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<Database> database = initDatabase();

    return MaterialApp(
      color: Colors.black,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/kangis/level/N1": (context) => KangiJlptLevel(level: 1),
        "/kangis/level/N2": (context) => KangiJlptLevel(level: 2),
        "/kangis/level/N3": (context) => KangiJlptLevel(level: 3),
        "/kangis/level/N4": (context) => KangiJlptLevel(level: 4),
        "/kangis/level/N5": (context) => KangiJlptLevel(level: 5),

        "/grammer/level/N1": (context) => GrammerLevel(level: 1),
        "/grammer/level/N2": (context) => GrammerLevel(level: 2),
        "/grammer/level/N3": (context) => GrammerLevel(level: 3),
        "/grammer/level/N4": (context) => GrammerLevel(level: 4),
        "/grammer/level/N5": (context) => GrammerLevel(level: 5),
        // "/kangi": null,
      },
    );
  }
}
