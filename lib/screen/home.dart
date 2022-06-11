import 'package:flutter/material.dart';
import 'package:japan_front/screen/japanLevelPage.dart';
import 'package:japan_front/screen/japanPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 200,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (content) {
                      return JapanPage();
                    }));
                  },
                  child: Text(
                    "日本語",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("韓国語"),
                ),
              )
            ],
          ),
        ));
  }
}
