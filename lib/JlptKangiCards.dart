import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:japan_front/Related_Japan.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/constants/configs.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/provider/HomeProver.dart';
import 'package:provider/provider.dart';

// 데이터 받기
class JlptKangiCards extends StatefulWidget {
  final int level;
  final int step;

  JlptKangiCards(this.level, this.step);

  @override
  State<JlptKangiCards> createState() => _JlptKangiCardsState();
}

class _JlptKangiCardsState extends State<JlptKangiCards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJlptKangis();
  }

  late Future<List<Kangi>> futureKangis;

  void getJlptKangis() {
    futureKangis = new KangiNetwork(Api.getKangiByJlptLevel)
        .getKangiByLevel(http.Client(), widget.level, widget.step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Kangi>>(
      future: futureKangis,
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data?.length == 0) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return JlptKangiCard(snapshot.data!, widget.level, widget.step);
        }
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}

// 단어 한개씩 순차적으로
class JlptKangiCard extends StatefulWidget {
  final int level;
  final int step;
  final List<Kangi> kangis;

  JlptKangiCard(this.kangis, this.level, this.step);

  @override
  State<JlptKangiCard> createState() => _JlptKangiCardState();
}

class _JlptKangiCardState extends State<JlptKangiCard> {
  List<bool> isButtonClick = List.filled(3, false);
  int knownVocaCnt = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeProvider homeProvider, child) => Scaffold(
        appBar: getCustomAppBar('N${widget.level} - Part${widget.step}'),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1}/${widget.kangis.length}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          ElevatedButton(
                            child: Text("연관 단어"),
                            style: ButtonStyle(
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RelatedJapan(widget.kangis[index].id);
                              }));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.kangis[index].japan,
                                style: kangiTextStyle,
                              ),
                            ],
                          ),
                          height: 200,
                        ),
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
                                          child:
                                              Text(widget.kangis[index].undoc),
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
                                          child:
                                              Text(widget.kangis[index].hundoc),
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
                                          child:
                                              Text(widget.kangis[index].korea),
                                          margin: EdgeInsets.only(left: 10),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      knownVocaCnt++;
                                      if (index + 1 == widget.kangis.length) {
                                        return Navigator.of(context).pop();
                                      }
                                      isButtonClick.fillRange(0, 3, false);
                                      setState(() {
                                        index++;
                                      });
                                    },
                                    child: Text('알고 있습니다.'),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (index + 1 == widget.kangis.length) {
                                          return Navigator.of(context).pop();
                                        }

                                        setState(() {
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
