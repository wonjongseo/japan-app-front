import 'package:flutter/material.dart';

class JapanPage extends StatelessWidget {
  const JapanPage({Key? key}) : super(key: key);

  ElevatedButton createButton(String level, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/kangis/level/N$level");
      },
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 100, 60),
          elevation: 0.0,
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      child: Text("N$level"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createButton("1", context),
            SizedBox(
              height: 35,
            ),
            createButton("2", context),
            SizedBox(
              height: 35,
            ),
            createButton("3", context),
            SizedBox(
              height: 35,
            ),
            createButton("4", context),
            SizedBox(
              height: 35,
            ),
            createButton("5", context),
          ],
        ),
      ),
    );
  }
}
