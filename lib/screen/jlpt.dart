import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:japan_front/model/Kaigi.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/screen/japanPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JLPT extends StatefulWidget {
  final int level;
  List<Kangi>? kangis;
  JLPT({Key? key, required this.level, this.kangis}) : super(key: key);

  @override
  State<JLPT> createState() => _JLPTState();
}

class _JLPTState extends State<JLPT> {
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
      _getShardData();
      futureKangis = new Network("http://localhost:4000/kangis/level")
          .fetchData(http.Client(), widget.level);
    }
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
                        Navigator.of(ctx).popUntil(ModalRoute.withName('/'));
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
                          return JLPT(
                            level: widget.level,
                            kangis: restKangis,
                          );
                        }));
                      },
                      child: const Text('混ざります。'),
                    ),
                    // TextButton(
                    //   onPressed: () => Navigator.pop(context2, 'OK'),
                    //   child: const Text('もっと見せます'),
                    // ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void _setShardData(int index) async {
    var key = 'last_index';
    SharedPreferences pref = await SharedPreferences.getInstance();
    /*
     * TODO
     * rest Data saving
     */
    pref.setInt(key, index);
  }

  void _getShardData() async {
    var key = 'last_index';
    SharedPreferences pref = await SharedPreferences.getInstance();

    var last_index = pref.getInt(key);

    if (last_index != 0) {
      AlertDialog dialog = AlertDialog(
        title: Text('進行したデータがあります。'),
        content: Text('続けませんか?'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  index = last_index!;
                });
              },
              child: Text('はい')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                return;
              },
              child: Text('いいえ')),
        ],
      );
      showDialog(context: context, builder: (context) => dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.kangis == null
        ? FutureBuilder<List<Kangi>>(
            future: futureKangis,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return SafeArea(
                  child: Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'N${widget.level}',
                        ),
                        backgroundColor: Colors.black,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _setShardData(index);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Container(
                            child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      //height: MediaQuery.of(context).size.height / 3.3333,
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            //
                                            primary: Colors.pink),
                                        child: Text('連関単語'),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            snapshot.data![index].japan,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 100),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                      : Text(snapshot
                                                          .data![index].undoc)),
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
                                                      : Text(snapshot
                                                          .data![index]
                                                          .hundoc)),
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
                                                      : Text(snapshot
                                                          .data![index].korea)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  primary: Colors.pink),
                                              onPressed: () {
                                                if (index + 1 ==
                                                    snapshot.data!.length) {
                                                  if (restKangis.isNotEmpty) {
                                                    shoWMessage();
                                                  } else {
                                                    return Navigator.of(context)
                                                        .pop(context);
                                                  }
                                                }
                                                switchingVoca();
                                                setState(() {
                                                  index++;
                                                });
                                              },
                                              child: Text('知っています。')),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  primary: Colors.pink),
                                              onPressed: () {
                                                restKangis
                                                    .add(snapshot.data![index]);
                                                index++;
                                                if (index ==
                                                    snapshot.data!.length) {
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
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
        : SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'N${widget.level}',
                  ),
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // _setShardData(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Container(
                      child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                //height: MediaQuery.of(context).size.height / 3.3333,
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      //
                                      primary: Colors.pink),
                                  child: Text('連関単語'),
                                  onPressed: () {},
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
                                    child: Text(
                                      widget.kangis![index].japan,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 100),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                                : Text(widget
                                                    .kangis![index].undoc)),
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
                                                : Text(widget
                                                    .kangis![index].hundoc)),
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
                                                : Text(widget
                                                    .kangis![index].korea)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.pink),
                                        onPressed: () {
                                          if (index + 1 ==
                                              widget.kangis!.length) {
                                            if (restKangis.isNotEmpty) {
                                              shoWMessage();
                                            } else {
                                              return Navigator.of(context)
                                                  .pop(context);
                                            }
                                          }
                                          switchingVoca();
                                          setState(() {
                                            index++;
                                          });
                                        },
                                        child: Text('知っています。')),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.pink),
                                        onPressed: () {
                                          restKangis.add(widget.kangis![index]);
                                          index++;
                                          if (index == widget.kangis!.length) {
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
}
