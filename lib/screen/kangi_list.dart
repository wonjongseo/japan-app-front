import 'package:flutter/material.dart';
import 'dart:math';
import 'package:japan_front/model/Kaigi.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;

class JLPT extends StatefulWidget {
  final int level;
  List<Kangi>? kangis;
  JLPT({Key? key, required this.level, this.kangis}) : super(key: key);

  @override
  State<JLPT> createState() => _JLPTState();
}

class _JLPTState extends State<JLPT> {
  late Future<List<Kangi>> futureKangis;
  late List<Kangi> temp = [];
  late List<Kangi> restKangis = [];
  List isButtonCheck = List<bool>.filled(3, true);
  Set seenJLPT = {};
  // late int randomNumber;
  late int totalCount;
  int index = 0;

  @override
  void initState() {
    super.initState();
    if (widget.kangis == null) {
      getJLPT();
    } else {
      print(widget.kangis);
    }
  }

  void getJLPT() {
    futureKangis = new Network("http://localhost:4000/kangis/level")
        .fetchData(http.Client(), widget.level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.kangis != null
          ? null
          : FutureBuilder<List<Kangi>>(
              future: futureKangis,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  temp = snapshot.data!;
                  totalCount = snapshot.data!.length;
                  print(totalCount);
                  return JLPTScreen(
                    temp: temp,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}

class JLPTScreen extends StatefulWidget {
  List<Kangi> temp;
  JLPTScreen({Key? key, required this.temp}) : super(key: key);

  @override
  State<JLPTScreen> createState() => _JLPTScreenState();
}

class _JLPTScreenState extends State<JLPTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.temp.japan,
            style: TextStyle(fontSize: 100),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isButtonCheck[0] ? Text("음독") : Text(widget.temp.undoc),
                onPressed: () {
                  setState(() {
                    isButtonCheck[0] = !isButtonCheck[0];
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isButtonCheck[1] ? Text("훈독") : Text(widget.temp.hundoc),
                onPressed: () {
                  setState(() {
                    isButtonCheck[1] = !isButtonCheck[1];
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child:
                    isButtonCheck[2] ? Text("읽는 법") : Text(widget.temp.korea),
                onPressed: () {
                  setState(() {
                    isButtonCheck[2] = !isButtonCheck[2];
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text("知っています"),
                onPressed: () {
                  if (index < totalCount - 1) {
                    index++;
                  } else {
                    Navigator.pop(context);
                  }
                  setState(() {
                    isButtonCheck.fillRange(0, 3, true);
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text("知っていません"),
                onPressed: () {
                  if (index < totalCount - 1) {
                    restKangis.add(widget.temp);
                    index++;
                  } else {
                    if (restKangis.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context2) {
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
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context2, '다른 레벨 보기');
                                        Navigator.pop(context);
                                      },
                                      child: const Text('出てきます'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context2, 'OK');
                                        restKangis.shuffle();
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return JLPT(
                                            level: widget.level,
                                            kangis: restKangis,
                                          );
                                        }));
                                      },
                                      child: const Text('混ざります。'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context2, 'OK'),
                                      child: const Text('もっと見せます'),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    } else
                      Navigator.pop(context);
                  }
                  setState(() {
                    isButtonCheck.fillRange(0, 3, true);
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
