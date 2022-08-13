import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_front/components/Button.dart';
import 'package:japan_front/page/Related_Japan.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/constants/configs.dart';
import 'package:japan_front/model/Kangi.dart';

class WordCardPage extends StatefulWidget {
  final int level;
  final int step;
  List<Kangi>? kangis;

  WordCardPage(this.level, this.step, this.kangis);

  @override
  State<WordCardPage> createState() => _WordCardPageState();
}

class _WordCardPageState extends State<WordCardPage> {
  List<bool> isButtonClick = List.filled(3, false);
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  void showMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar('N${widget.level} - Part${widget.step}'),
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
                      style: kangiTextStyle,
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: getCButtonStyle(),
                            onPressed: () {
                              isButtonClick.fillRange(0, 3, false);

                              if (index + 1 == widget.kangis!.length) {
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
                              onPressed: () {
                                isButtonClick.fillRange(0, 3, false);

                                setState(() {});
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
}
