import 'package:flutter/material.dart';
import 'package:japan_front/screen/kangi/KangiJlptLevel.dart';
import 'package:japan_front/screen/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<Database> initDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
  //       onCreate: (db, version) {
  //     return db.execute(
  //       "create table japan(id text ,"
  //       "japan text, korea text, undoc text, hundoc text, jlpt text, step text)",
  //     );
  //   }, version: 1);
  // }

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
        "/kangis/leㅌㅌvel/N5": (context) => KangiJlptLevel(level: 5),
        // "/kangi": null,
      },
    );
  }
}
