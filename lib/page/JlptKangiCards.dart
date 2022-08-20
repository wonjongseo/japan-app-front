import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_front/components/CButton.dart';
import 'package:japan_front/controller/progressing-controller.dart';
import 'package:japan_front/page/Related_Japan.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class WordCardPage extends StatefulWidget {
  final String level;
  final int step;
  String? firstWord;
  late int lastCnt;
  final int totalCnt;
  List<Kangi>? kangis;
  bool? isContinue;

  SharedPreferences? pref;
  WordCardPage(
      {required this.level,
      required this.step,
      this.firstWord,
      this.kangis,
      required this.totalCnt,
      required this.lastCnt,
      this.pref,
      this.isContinue});

  @override
  State<WordCardPage> createState() => _WordCardPageState();
}

class _WordCardPageState extends State<WordCardPage> {
  List<bool> isButtonClick = List.filled(3, false);
  Set<String> unKnownIdx = {};
  int index = 0;
  @override
  void initState() {
    super.initState();
    if (widget.lastCnt <= 1) {
      List<String>? prevUnKnowenIdx = widget.pref
          ?.getStringList(getUnKnownKey(widget.firstWord!, widget.step));

      if (prevUnKnowenIdx != null) {
        unKnownIdx = prevUnKnowenIdx.toSet();
      }

      if (widget.isContinue == false) {
        index = widget.lastCnt;
      }
    }

    if (widget.lastCnt == widget.totalCnt) {
      index = 0;
    }
  }

  String getUnKnownKey(String level, int step) {
    return level + "-" + step.toString() + "-UN";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    String key = getUnKnownKey(widget.firstWord!, widget.step);

    if (widget.pref != null) {
      if (unKnownIdx.isNotEmpty) {
        widget.pref!.setStringList(key, unKnownIdx.toList());
      }
    }
    print(widget.pref?.getStringList(key));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar('${widget.level} - Part${widget.step}'),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index + 1}/${widget.kangis?.length}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        style: getCButtonStyle(),
                        child: Text(
                          "연관 단어",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => RelatedJapan(widget.kangis![index].id));
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: Get.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.kangis![index].japan,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 130,
                      ),
                    ),
                  ],
                ),
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              style: getCButtonStyle(),
                              onPressed: () {
                                setState(() {
                                  isButtonClick[2] = true;
                                });
                              },
                              child: Text(
                                '의미',
                                style: TextStyle(color: Colors.black),
                              )),
                          !isButtonClick[2]
                              ? Text("")
                              : Container(
                                  child: Text(widget.kangis![index].korea),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: getCButtonStyle(),
                              onPressed: () {
                                setState(() {
                                  isButtonClick[0] = true;
                                });
                              },
                              child: Text(
                                '음독',
                                style: TextStyle(color: Colors.black),
                              )),
                          !isButtonClick[0]
                              ? Text("")
                              : Container(
                                  child: Text(widget.kangis![index].undoc),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: getCButtonStyle(),
                              onPressed: () {
                                setState(() {
                                  isButtonClick[1] = true;
                                });
                              },
                              child: Text(
                                '훈독',
                                style: TextStyle(color: Colors.black),
                              )),
                          !isButtonClick[1]
                              ? Text("")
                              : Container(
                                  child: Text(widget.kangis![index].hundoc),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: getCButtonStyle(),
                            onPressed: () async {
                              widget.lastCnt++;
                              Get.find<ProgressingController>().increate(
                                  widget.firstWord!,
                                  widget.step,
                                  widget.lastCnt.toString());

                              isButtonClick.fillRange(0, 3, false);

                              if (index + 1 == widget.kangis!.length) {
                                if (unKnownIdx.isNotEmpty) {
                                  dynamic isContinue =
                                      await _showDialog(unKnownIdx.length);

                                  if (isContinue == true) {
                                    List<Kangi> unKnownWord = [];

                                    for (int i = 0;
                                        i < unKnownIdx.length;
                                        i++) {
                                      unKnownWord.add(widget.kangis![
                                          int.parse(unKnownIdx.elementAt(i))]);
                                    }
                                    unKnownWord.shuffle();

                                    await Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (builder) {
                                      return WordCardPage(
                                        level: widget.level,
                                        step: widget.step,
                                        firstWord: widget.firstWord,
                                        totalCnt: unKnownWord.length - 1,
                                        kangis: unKnownWord,
                                        lastCnt: widget.lastCnt,
                                        isContinue: true,
                                      );
                                    }));
                                  }
                                } else {}
                                return Navigator.of(context).pop();
                              }
                              setState(() {
                                index++;
                              });
                            },
                            child: Text(
                              '알고 있습니다.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                              style: getCButtonStyle(),
                              onPressed: () async {
                                isButtonClick.fillRange(0, 3, false);
                                widget.lastCnt++;
                                Get.find<ProgressingController>().increate(
                                    widget.firstWord!,
                                    widget.step,
                                    widget.lastCnt.toString());
                                unKnownIdx.add(index.toString());

                                if (index + 1 == widget.kangis!.length) {
                                  if (unKnownIdx.isNotEmpty) {
                                    bool isContinue =
                                        await _showDialog(unKnownIdx.length);

                                    if (isContinue) {
                                      List<Kangi> unKnownWord = [];

                                      for (int i = 0;
                                          i < unKnownIdx.length;
                                          i++) {
                                        unKnownWord.add(widget.kangis![
                                            int.parse(
                                                unKnownIdx.elementAt(i))]);
                                      }
                                      unKnownWord.shuffle();

                                      await Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (builder) {
                                        return WordCardPage(
                                          level: widget.level,
                                          step: widget.step,
                                          firstWord: widget.firstWord,
                                          totalCnt: unKnownWord.length - 1,
                                          kangis: unKnownWord,
                                          lastCnt: widget.lastCnt,
                                          isContinue: true,
                                        );
                                      }));
                                    }
                                  } else {}
                                  return Navigator.of(context).pop();
                                }
                                setState(() {
                                  index++;
                                });
                              },
                              child: Text(
                                '모르겠습니다.',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDialog(int unKnownCnt) async {
    return await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              '모르는 단어가 ${unKnownCnt}개 있습니다',
              style: TextStyle(fontSize: 17),
            ),
            content: Text(
              '단어를 섞어서 보시겠습니까?',
              style: TextStyle(fontSize: 15),
            ),
            actions: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        'NO',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
