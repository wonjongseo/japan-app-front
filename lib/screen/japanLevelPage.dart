import 'package:flutter/material.dart';
import 'package:japan_front/screen/kangi_list.dart';

class JapanLevelPage extends StatelessWidget {
  const JapanLevelPage({Key? key}) : super(key: key);

  Container getButtonUI(int level, BuildContext content) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Navigator.push(content, MaterialPageRoute(builder: (content) {
            return JLPT(level: level);
          }));
        },
        color: Colors.blue,
        child: Text(
          "レベル $level",
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
        title: Text("日本語 レベル"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            getButtonUI(1, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(2, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(3, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(4, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(5, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(6, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(8, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(9, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(1, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(1, context),
            SizedBox(
              height: 15,
            ),
            getButtonUI(1, context),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
