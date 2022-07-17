import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/main.dart';
import 'package:japan_front/page/n-level.dart';

class App extends GetView<KangiController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                iconSize: 60,
                onPressed: () {
                  Get.to(() => NLevel());
                },
                icon: Icon(
                  Icons.star_outlined,
                )),
            Text(
              "Start!!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
