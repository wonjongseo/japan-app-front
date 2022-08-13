import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/api/wordNetworktest.dart';
import 'package:japan_front/components/Button.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/page/kangi-page.dart';

class NLevelPage extends GetView<KangiController> {
  Widget _customButton(String level, BuildContext context) {
    return Container(
      height: Get.width / 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          style: getCButtonStyle(),
          onPressed: () async {
            try {
              await controller.loadKangisByLevels(level);

              Get.to(() => StepPage(level: "N" + level));
            } on Exception catch (e) {
              print(e);
              return;
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 2, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '미학습',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'N${level}',
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width - 180,
                      child: SliderTheme(
                        child: Slider(
                          value: 0,
                          max: 0,
                          min: 0,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          onChanged: (double value) {},
                        ),
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10,
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0.0),
                        ),
                      ),
                    ),
                    Text(
                      'N${level}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar('일본어 단어'),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _customButton("1", context),
            _customButton("2", context),
            _customButton("3", context),
            _customButton("4", context),
            _customButton("5", context),
          ],
        ),
      ),
    );
  }
}
