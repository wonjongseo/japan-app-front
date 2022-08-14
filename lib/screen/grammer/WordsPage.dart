import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/components/CButton.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Kangi.dart';

import 'package:japan_front/page/step-page.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        '사전순',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: firstWord.length,
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
                  Get.to(() => StepPage(
                        appBarTitle: firstWord.keys.elementAt(index),
                        firstWord: firstWord.values.elementAt(index),
                      ));
                },
                child: Text(
                  firstWord.keys.elementAt(index),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
