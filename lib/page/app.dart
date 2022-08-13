import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/main.dart';
import 'package:japan_front/page/n-level.dart';
import 'package:japan_front/screen/grammer/WordsPage.dart';

class App extends GetView<KangiController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                        iconSize: 100,
                        color: Colors.lightBlue,
                        onPressed: () {
                          Get.to(() => NLevel());
                          // Get.to(() => WordsPage());
                        },
                        icon: Icon(
                          Icons.star_outlined,
                        )),
                    Text("JLPT", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    IconButton(
                        color: Colors.redAccent,
                        iconSize: 100,
                        onPressed: () {
                          // Get.to(() => NLevel());
                          Get.to(() => WordsPage());
                        },
                        icon: Icon(
                          Icons.star_outlined,
                        )),
                    Text("사전순", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
