import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:japan_front/controller/progressController.dart';
import 'package:japan_front/page/Related_Japan.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/constants/configs.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class JlptKangiCard extends StatefulWidget {
  final int level;
  final int step;
  List<Kangi>? kangis;

  JlptKangiCard(this.level, this.step, this.kangis);

  @override
  State<JlptKangiCard> createState() => _JlptKangiCardState();
}

class _JlptKangiCardState extends State<JlptKangiCard> {
  List<bool> isButtonClick = List.filled(3, false);
  int index = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    // ProgressController.to.save(widget.level, widget.step);

    super.dispose();
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
                        child: Text("연관 단어"),
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
                              onPressed: () {
                                setState(() {
                                  isButtonClick[0] = true;
                                });
                              },
                              style: correctButtonStyle,
                              child: Text(
                                '음독',
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
                              onPressed: () {
                                setState(() {
                                  isButtonClick[1] = true;
                                });
                              },
                              style: correctButtonStyle,
                              child: Text(
                                '훈독',
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
                              onPressed: () {
                                setState(() {
                                  isButtonClick[2] = true;
                                });
                              },
                              style: correctButtonStyle,
                              child: Text(
                                '의미',
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
                            onPressed: () {
                              isButtonClick.fillRange(0, 3, false);

                              if (index + 1 == widget.kangis!.length) {
                                return Navigator.of(context).pop();
                              }
                              setState(() {
                                index++;
                              });
                            },
                            child: Text('알고 있습니다.'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                isButtonClick.fillRange(0, 3, false);

                                if (index + 1 == widget.kangis!.length) {
                                  var unKnownKangi = ProgressController.to
                                      .getUnknownKangi(
                                          '${widget.level}-${widget.step}');

                                  if (unKnownKangi != null) {
                                    if (unKnownKangi.length != 0) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return Container(
                                              child: Text("asdasd"),
                                            );
                                          });
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context2) {
                                      //       return AlertDialog(
                                      //         title: Text(
                                      //           "知らない単語が${unKnownKangi.length}個残っています。",
                                      //           style: TextStyle(fontSize: 18),
                                      //         ),
                                      //         content: const Text(
                                      //           '単語を混ざろうとはOKボタンを押してください。',
                                      //           style: TextStyle(fontSize: 11),
                                      //         ),
                                      //         actions: <Widget>[
                                      //           Row(
                                      //             children: [
                                      //               TextButton(
                                      //                 onPressed: () {
                                      //                   Navigator.pop(context2,
                                      //                       '다른 레벨 보기');
                                      //                   Navigator.pop(context);
                                      //                 },
                                      //                 child:
                                      //                     const Text('出てきます'),
                                      //               ),
                                      //               TextButton(
                                      //                 onPressed: () {
                                      //                   Navigator.pop(
                                      //                       context2, 'OK');
                                      //                   unKnownKangi.shuffle();
                                      //                   Get.to(() =>
                                      //                       JlptKangiCard(
                                      //                           widget.level,
                                      //                           widget.step,
                                      //                           unKnownKangi));
                                      //                 },
                                      //                 child:
                                      //                     const Text('混ざります。'),
                                      //               ),
                                      //               TextButton(
                                      //                 onPressed: () =>
                                      //                     Navigator.pop(
                                      //                         context2, 'OK'),
                                      //                 child:
                                      //                     const Text('もっと見せます'),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         ],
                                      //       );
                                      //     });

                                    }
                                  }
                                  return Navigator.of(context).pop();
                                }
                                setState(() {
                                  ProgressController.to.addUnknownKangi(
                                      widget.kangis![index],
                                      widget.level,
                                      widget.step);
                                  index++;
                                });
                              },
                              child: Text('모르겠습니다.')),
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
