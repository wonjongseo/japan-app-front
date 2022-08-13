import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:japan_front/api/wordNetworktest.dart';
import 'package:japan_front/components/Button.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/page/JlptKangiCards.dart';
import 'package:japan_front/page/kangi-page.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  List<String> firstName = [
    '가',
    '나',
    '다',
    '라',
    '마',
    '바',
    '사',
    '아',
    '자',
    '차',
    '카',
    '타',
    '파',
    '하',
    '외'
  ];
  List<String> engFirstName = [
    'ga',
    'na',
    'da',
    'ra',
    'ma',
    'ba',
    'sa',
    'a',
    'ja',
    'tya',
    'ka',
    'ta',
    'pa',
    'ha',
    'acc',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        '사전순',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: firstName.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ElevatedButton(
                style: getCButtonStyle(),
                onPressed: () async {
                  List<Kangi> words = await WordNetworkTest()
                      .getWords(http.Client(), engFirstName[index]);

                  Get.to(
                      () => KangiPage(level: firstName[index], kangis: words));
                },
                child: Text(
                  firstName[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
