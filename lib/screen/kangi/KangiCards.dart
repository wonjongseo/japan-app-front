import 'package:flutter/material.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/model/Japan.dart';

import 'package:japan_front/model/Kaigi.dart';
import 'package:japan_front/api/network.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/screen/relatedJapan.dart';

import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

class KangiCards extends StatefulWidget {
  final int level;
  final int step;

  List<Kangi>? kangis;
  KangiCards({
    Key? key,
    required this.level,
    required this.step,
    this.kangis,
  }) : super(key: key);

  @override
  State<KangiCards> createState() => _KangiCardsState();
}

class _KangiCardsState extends State<KangiCards> {
  late Future<List<Kangi>> futureKangis;
  List<Kangi> restKangis = List.empty(growable: true);

  List<bool> isClick = List.filled(3, false);

  int index = 0;

  @override
  void initState() {
    super.initState();

    getJLPT();
  }

  void switchingVoca() {
    isClick.fillRange(0, 3, false);
  }

  void getJLPT() {
    if (widget.kangis == null) {
      futureKangis = new KangiNetwork(Api.getKangisByJlptLevel)
          .getKangisByLevel(http.Client(), widget.level, widget.step);
    }
  }

  void _setPrevIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return widget.kangis == null
        ? FutureBuilder<List<Kangi>>(
            future: futureKangis,
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.data?.length == 0) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return drawScreen(snapshot.data!);
              }
              return Center(child: CircularProgressIndicator());
            })
        : drawScreen(widget.kangis!);
  }

  bool isLongerThen15Word(String word) {
    if (word.length >= 15) return true;
    return false;
  }

  SafeArea drawScreen(List<Kangi> kangis) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'N${widget.level}  level ${widget.step}',
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () async {
                if (restKangis.length >= 1) {
                  // _setPrevIndex();
                  // _insertKangi();
                }

                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Container(
                child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${index + 1} / ${kangis.length}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              //
                              primary: Colors.pink,
                            ),
                            child: Text('連関単語'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext content) =>
                                          RelatedJapan(id: kangis[index].id)));
                            },
                          ),
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              child: Text(
                                kangis[index].japan,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 100),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.pink,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isClick[0] = !isClick[0];
                                        });
                                      },
                                      child: !isClick[0]
                                          ? Text('운독')
                                          : isLongerThen15Word(
                                                  kangis[index].undoc)
                                              ? TextButton(
                                                  onPressed: () {
                                                    print(kangis[index].undoc);
                                                  },
                                                  child: Text(kangis[index]
                                                      .undoc
                                                      .substring(0, 15)))
                                              : Text(kangis[index].undoc)),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.pink),
                                      onPressed: () {
                                        setState(() {
                                          isClick[1] = !isClick[1];
                                        });
                                      },
                                      child: !isClick[1]
                                          ? Text('훈독')
                                          : Text(kangis[index].hundoc)),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.pink),
                                      onPressed: () {
                                        setState(() {
                                          isClick[2] = !isClick[2];
                                        });
                                      },
                                      child: !isClick[2]
                                          ? Text('한자')
                                          : Text(kangis[index].korea)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.pink),
                                  onPressed: () {
                                    index++;
                                    if (index == kangis.length) {
                                      if (restKangis.isNotEmpty) {
                                        shoWMessage();
                                      } else {
                                        return Navigator.of(context)
                                            .pop(context);
                                      }
                                    } else {
                                      switchingVoca();
                                      setState(() {});
                                    }
                                  },
                                  child: Text('知っています。')),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.pink,
                                  ),
                                  onPressed: () {
                                    restKangis.add(
                                      kangis[index],
                                    );
                                    index++;
                                    if (index == kangis.length) {
                                      if (restKangis.isNotEmpty) {
                                        shoWMessage();
                                      } else {
                                        return Navigator.of(context)
                                            .pop(context);
                                      }
                                    } else {
                                      switchingVoca();
                                      setState(() {});
                                    }
                                  },
                                  child: Text('知っていません。')),
                            ],
                          ),
                        )),
                  ]),
            )),
          )),
    );
  }

  void shoWMessage() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              "知らない単語が${restKangis.length}個残っています。",
              style: TextStyle(fontSize: 18),
            ),
            content: const Text(
              '単語を混ざろうとはOKボタンを押してください。',
              style: TextStyle(fontSize: 11),
            ),
            actions: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).popUntil(ModalRoute.withName(
                            '/kangis/level/N${widget.level}'));
                      },
                      child: const Text(
                        '出てきます',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        restKangis.shuffle();
                        Navigator.pop(ctx);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return KangiCards(
                            level: widget.level,
                            step: widget.step,
                            kangis: restKangis,
                          );
                        }));
                      },
                      child: const Text('混ざります。'),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
