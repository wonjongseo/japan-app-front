import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/components/CButton.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/progressing-controller.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/page/step-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TT extends StatefulWidget {
  @override
  State<TT> createState() => _TTState();
}

class _TTState extends State<TT> {
  late SharedPreferences _pref;

  Map<String, String> firstWord = {
    '가': 'ga',
    '나': 'na',
    '다': 'da',
    '라': 'ra',
    '마': 'ma',
    '바': 'ba',
    '사': 'sa',
    '아': 'a',
    '자': 'ja',
    '차': 'tya',
    '카': 'ka',
    '타': 'ta',
    '파': 'pa',
    '하': 'ha',
    '외': 'acc',
  };

  void geta() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        '사전순',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  firstWord.length,
                  (index) => _customButton(
                      firstWord.keys.elementAt(index), context, index))),
        ),
      ),
    );
  }

  Widget _customButton(String level, BuildContext context, int index) {
    return Container(
      height: Get.width / 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          style: getCButtonStyle(),
          onPressed: () async {
            try {
              Get.to(() => StepPage(
                    appBarTitle: firstWord.keys.elementAt(index),
                    firstWord: firstWord.values.elementAt(index),
                  ));
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
                  '${level}',
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
                      '${level}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
