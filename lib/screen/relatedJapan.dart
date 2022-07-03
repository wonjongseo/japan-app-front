import 'package:flutter/material.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/japanNetwork.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:japan_front/api/network.dart';
import 'package:http/http.dart' as http;

class RelatedJapan extends StatefulWidget {
  final String id;
  const RelatedJapan({Key? key, required this.id}) : super(key: key);

  @override
  State<RelatedJapan> createState() => _RelatedJapanState();
}

class _RelatedJapanState extends State<RelatedJapan> {
  late Future<List<Japan>> futureJapans;

  Widget isLongerThen13Word(String word) {
    return word.length >= 13
        ? TextButton(
            onPressed: () {
              print(word);
              shoWMessage(word);
            },
            child: Text(word.substring(0, 13) + "..."))
        : Text(
            word,
            style: TextStyle(color: Colors.pink),
          );
  }

  @override
  void initState() {
    super.initState();
    getJapan();
  }

  late List<bool> isClickedMean;
  late List<bool> isClickedYomikata;

  void getJapan() {
    futureJapans = JapanNetwork(Api.getJapansByKangiId)
        .getJapansByKangiId(http.Client(), widget.id);

    futureJapans.then((value) => {
          isClickedYomikata = List<bool>.filled(value.length, false),
          isClickedMean = List<bool>.filled(value.length, false),
        });
  }

  void shoWMessage(String word) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              '意味',
              style: TextStyle(fontSize: 18),
            ),
            content: Text(
              word,
              style: TextStyle(fontSize: 13),
            ),
            actions: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("連関単語"),
      ),
      body: FutureBuilder<List<Japan>>(
        future: futureJapans,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 30, left: 30, bottom: 20),
              child: Scaffold(
                  body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 70,
                              child: Text(
                                snapshot.data![index].japan,
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 20),
                              ),
                            ),
                            Container(
                                width: 160,
                                child: Center(
                                    child: !isClickedMean[index]
                                        ? TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.pink),
                                            onPressed: () {
                                              setState(() {
                                                isClickedMean[index] =
                                                    !isClickedMean[index];
                                              });
                                            },
                                            child: Text("意味",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          )
                                        : isLongerThen13Word(
                                            snapshot.data![index].korea)

                                    /*
                                         child: !isClick[0]
                                          ? Text('운독') : isLongerThen13Word(kangis[index].undoc) ? TextButton(
                                                  onPressed: () {
                                                    print(kangis[index].undoc);
                                                  },
                                                  child: Text(kangis[index]
                                                      .undoc
                                                      .substring(0, 15)))
                                              : Text(kangis[index].undoc))
                                         */
                                    )),
                            Container(
                                width: 100,
                                child: Center(
                                  child: !isClickedYomikata[index]
                                      ? TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.pink),
                                          onPressed: () {
                                            setState(() {
                                              print(isClickedYomikata[index]);
                                              isClickedYomikata[index] =
                                                  !isClickedYomikata[index];
                                            });
                                          },
                                          child: Text(
                                            "読み方",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                          ))
                                      : Text(
                                          snapshot.data![index].yomikata,
                                          style: TextStyle(
                                            color: Colors.pink,
                                          ),
                                        ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
