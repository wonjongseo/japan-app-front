import 'package:flutter/material.dart';
import 'package:japan_front/screen/kangi/KangiCards.dart';
import 'package:sqflite/sqlite_api.dart';

class KangiJlptLevel extends StatelessWidget {
  final int level;

  const KangiJlptLevel({Key? key, required this.level}) : super(key: key);

  Container drawScreen(int step, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 100, 60),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      KangiCards(level: level, step: step)));
        },
        child: Text(
          "レベル $step",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      height: 57,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('N${level}'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              drawScreen(1, context),
              drawScreen(2, context),
              drawScreen(3, context),
              drawScreen(4, context),
              drawScreen(5, context),
              drawScreen(6, context),
              drawScreen(8, context),
              drawScreen(9, context),
              drawScreen(10, context),
              drawScreen(11, context),
              drawScreen(12, context),
            ],
          ),
        ),
      ),
    );
  }
}
