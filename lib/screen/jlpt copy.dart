import 'package:flutter/material.dart';
import 'dart:math';
import 'package:japan_front/model/Kaigi.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/screen/question.dart';
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
  late List<Kangi> temp = [];
  late List<Kangi> restKangis = [];
  List isButtonCheck = List<bool>.filled(3, true);
  Set seenJLPT = {};
  late int totalCount;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _getShardData();
    if (widget.kangis == null) {
      getJLPT();
    } else {
      temp.addAll(widget.kangis!);
      totalCount = temp.length;
    }
  }

  void getJLPT() {
    futureKangis = new Network("http://localhost:4000/kangis/level")
        .fetchData(http.Client(), widget.level);
  }

  Scaffold getScaffold() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: Colors.red,
            height: 40,
            margin: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              child: Text("連間単語"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Question(id: temp[index].id);
                }));
              },
            ),
          ),
          Column(
            children: [
              Text(
                temp[index].japan,
                style: TextStyle(fontSize: 100),
              ),
              if (!isButtonCheck[1])
                Container(
                  child: Text(temp[index].hundoc),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child:
                        isButtonCheck[0] ? Text("음독") : Text(temp[index].undoc),
                    onPressed: () {
                      setState(() {
                        isButtonCheck[0] = !isButtonCheck[0];
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isButtonCheck[1]
                        ? Text("훈독")
                        : Text(temp[index].hundoc),
                    onPressed: () {
                      setState(() {
                        isButtonCheck[1] = !isButtonCheck[1];
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isButtonCheck[2]
                        ? Text("읽는 법")
                        : Text(temp[index].korea),
                    onPressed: () {
                      setState(() {
                        isButtonCheck[2] = !isButtonCheck[2];
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text("知っています"),
                    onPressed: () {
                      if (index < totalCount - 1) {
                        index++;
                      } else {
                        if (restKangis.isNotEmpty) {
                          shoWMessage();
                        } else
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text("知っていません"),
                    onPressed: () {
                      if (index < totalCount - 1) {
                        restKangis.add(temp[index]);
                        index++;
                      } else {
                        if (restKangis.isNotEmpty) {
                          shoWMessage();
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
            ],
          ),
          Container(
            height: 100,
          ),
        ],
      ),
    );
  }

  void shoWMessage() {
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context2);
                      Navigator.pop(context);
                    },
                    child: const Text('出てきます'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context2);
                      Navigator.pop(context);
                      restKangis.shuffle();
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return JLPT(
                          level: widget.level,
                          kangis: restKangis,
                        );
                      }));
                    },
                    child: const Text('混ざります。'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context2, 'OK'),
                    child: const Text('もっと見せます'),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _setShardData(int index) async {
    var key = 'last_index';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, index);
  }

  void _getShardData() async {
    var key = 'last_index';
    SharedPreferences pref = await SharedPreferences.getInstance();

    var last_index = pref.getInt(key);

    if (last_index != 0) {
      AlertDialog dialog = AlertDialog(
        title: Text('기존에 진행하던 데이터가 있습니다.'),
        content: Text('계속 진행하시겠습니까 ?'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  index = last_index!;
                });
              },
              child: Text('Yes')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                return;
              },
              child: Text('No')),
        ],
      );
      showDialog(context: context, builder: (context) => dialog);
    }
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
            _setShardData(index);
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.kangis != null
          ? getScaffold()
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
                  if (totalCount == 0) {
                    return Scaffold(
                      body: Center(child: Text("No DATA")),
                    );
                  } else {
                    return getScaffold();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
