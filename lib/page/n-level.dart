import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/hive/hive_db.dart';

import 'package:japan_front/page/kangi-page.dart';

class NLevel extends GetView<KangiController> {
  Widget _customButton(int level, BuildContext context) {
    return Container(
      height: Get.width / 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {
            try {
              await controller.loadKangisByLevel(level);
              Get.to(() => KangiPage(level: level));
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
                Text('미학습'),
                Text('N${0}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width - 180,
                      child: SliderTheme(
                        child: Slider(
                          // value: homeProvider.levels[widget.level]?.lastIndex ==
                          //         null
                          //     ? 0
                          //     : homeProvider.levels[widget.level]!.lastIndex
                          //         .toDouble(),
                          // max: homeProvider.levels[widget.level]?.totalCnt ==
                          //         null
                          //     ? 0
                          //     : homeProvider.levels[widget.level]!.totalCnt!
                          //         .toDouble(),
                          value: 0,
                          max: 0,
                          min: 0,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          onChanged: (double value) {},
                        ),
                        data: SliderTheme.of(context).copyWith(
                          // slider height
                          trackHeight: 10,
                          // remove padding
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0.0),
                        ),
                      ),
                    ),
                    Text('N${0}'),
                    // getPercentage(homeProvider.levels[widget.level]?.lastIndex,
                    //     homeProvider.levels[widget.level]?.totalCnt),
                    // '학습률: ${homeProvider.levels[widget.level]?.lastIndex} / ${homeProvider.levels[widget.level]?.totalCnt} ${(homeProvider.levels[widget.level]!.lastIndex / homeProvider.levels[widget.level]!.totalCnt! * 100).ceil()}[%]',
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
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          HiveDB.instance.deleteAll();
          HiveDB.instance.deleteKangisAll();
        }),
        child: Icon(Icons.add),
      ),
      appBar: getCustomAppBar('일본어 단어'),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _customButton(1, context),
            _customButton(2, context),
            _customButton(3, context),
            _customButton(4, context),
            _customButton(5, context),
          ],
        ),
      ),
    );
  }
}
