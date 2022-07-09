import 'package:flutter/material.dart';

class GrammerHome extends StatelessWidget {
  const GrammerHome({Key? key}) : super(key: key);

  Widget drawSreen(String level, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/grammer/level/N$level");
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
            drawSreen("1", context),
            SizedBox(
              height: 35,
            ),
            drawSreen("2", context),
            SizedBox(
              height: 35,
            ),
            drawSreen("3", context),
            SizedBox(
              height: 35,
            ),
            drawSreen("4", context),
            SizedBox(
              height: 35,
            ),
            drawSreen("5", context),
          ],
        ),
      ),
    );
  }
}
