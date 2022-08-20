import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/components/CButton.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/progressing-controller.dart';
import 'package:japan_front/page/JlptKangiCards.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Kangi.dart';

/*
  widget.firstWord != null ? 사전순  : JLPT
 */

// ignore: must_be_immutable
class StepPage extends StatefulWidget {
  final String appBarTitle;
  String? firstWord;

  StepPage({Key? key, required this.appBarTitle, this.firstWord})
      : super(key: key);

  @override
  State<StepPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StepPage> {
  late Future<List<Kangi>> kangis;
  late SharedPreferences _prefs;
  List<int> totalCount = [];
  List<String> lastIndex = [];

  ScrollController? _scrollController = ScrollController();

  Future<void> loadWords() async {
    if (widget.firstWord != null) {
      kangis = WordNetwork().getWords(http.Client(), widget.firstWord!);
    } else {
      kangis =
          WordNetwork().getKangisByLevel(http.Client(), widget.appBarTitle);
    }
  }

  Future<void> getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    widget.firstWord != null
        ? lastIndex = _prefs.getStringList(widget.firstWord!)!
        : null;

    Get.find<ProgressingController>()
        .setProgressing(widget.firstWord!, lastIndex);
  }

  bool _isSuccess(int index) {
    return int.parse(lastIndex[index]) >= totalCount[index];
  }

  @override
  void initState() {
    super.initState();

    getSharedPreferences();
    loadWords();
  }

  @override
  void dispose() {
    if (widget.firstWord != null) {
      List<String> list =
          Get.find<ProgressingController>().getProgressing(widget.firstWord!);

      _prefs.setStringList(widget.firstWord!, list);
    }

    super.dispose();
  }

  String getUnKnownKey(String level, int step) {
    return level + "-" + step.toString() + "-UN";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.firstWord != null
          ? getCustomAppBar(
              '${widget.appBarTitle}',
            )
          : getCustomAppBar(
              'N${widget.appBarTitle}',
            ),
      body: GetBuilder<ProgressingController>(builder: (controller) {
        return SafeArea(
          child: FutureBuilder<List<Kangi>>(
            builder: ((context, snapshot) {
              print(controller.progressing[widget.firstWord]);
              if (snapshot.hasData) {
                _getTotalCnt(snapshot.data!);

                return Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        child: ElevatedButton(
                          style: getCButtonStyle(),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: _isSuccess(index)
                                            ? Colors.green
                                            : Colors.grey,
                                        size: 16,
                                      )
                                    ]),
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 27,
                                      color: Colors.black),
                                ),
                                Text(
                                  '${controller.progressing[widget.firstWord]?[index]}/${totalCount[index]}',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )),
                          onPressed: () {
                            if (widget.firstWord != null) {
                              if (int.parse(lastIndex[index]) ==
                                  totalCount[index]) {
                                Get.find<ProgressingController>()
                                    .reset(widget.firstWord!, index);
                              } else {}
                            }

                            Get.to(() => widget.firstWord != null
                                ? WordCardPage(
                                    level: widget.appBarTitle,
                                    step: index,
                                    firstWord: widget.firstWord,
                                    totalCnt: totalCount[index],
                                    kangis: trimKangis(snapshot.data!, index),
                                    lastCnt: int.parse(lastIndex[index]),
                                    pref: _prefs,
                                    isContinue: false,
                                  )
                                : WordCardPage(
                                    level: 'N${widget.appBarTitle}',
                                    step: index,
                                    totalCnt: 0,
                                    kangis: trimKangis(snapshot.data!, index),
                                    lastCnt: 0));
                          },
                        ),
                      );
                    },
                    itemCount:
                        ((snapshot.data as List<Kangi>).length / 15).ceil(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Error ${snapshot.error}'),
                );
              }

              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ]),
              );
            }),
            future: kangis,
          ),
        );
      }),
    );
  }

  void _getTotalCnt(List data) {
    for (int i = 0; i < data.length / 15; i++) {
      if (i * 15 + 15 > data.length) {
        totalCount.add(data.length % 15);
      } else
        totalCount.add(15);
    }
  }

  List<Kangi> trimKangis(List<Kangi> kangi, int index) {
    if (index * 15 + 15 > kangi.length) {
      return kangi.sublist(index * 15);
    }
    return kangi.sublist(index * 15, index * 15 + 15);
  }
}
