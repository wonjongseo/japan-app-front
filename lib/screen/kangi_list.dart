import 'package:flutter/material.dart';
import 'dart:math';
import 'package:japan_front/model/Kaigi.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;

class KangiList extends StatefulWidget {
  final int level;
  const KangiList({Key? key, required this.level}) : super(key: key);

  @override
  State<KangiList> createState() => _KangiListState();
}

class _KangiListState extends State<KangiList> {
  List isClick = List<bool>.filled(3, true);

  late int totalCount;
  int correctCount = 0;

  late List<Kangi> tempList;
  late int number = Random().nextInt(totalCount);
  late Future<List<Kangi>> futureKangis;

  @override
  void initState() {
    super.initState();
    futureKangis = new Network("http://localhost:4000/kangi")
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
            isClick.fillRange(0, 3, true);
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Kangi>>(
        future: futureKangis,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            tempList = snapshot.data!;
            totalCount = tempList.length;

            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data![number].japan,
                    style: TextStyle(fontSize: 100),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: isClick[0]
                            ? Text("음독")
                            : Text(tempList[number].undoc),
                        onPressed: () {
                          setState(() {
                            isClick[0] = !isClick[0];
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: isClick[1]
                            ? Text("훈독")
                            : Text(tempList[number].hundoc),
                        onPressed: () {
                          setState(() {
                            isClick[1] = !isClick[1];
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: isClick[2]
                            ? Text("읽는 법")
                            : Text(tempList[number].korea),
                        onPressed: () {
                          setState(() {
                            isClick[2] = !isClick[2];
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
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("知っています"),
                        onPressed: () {
                          if (0 == totalCount) {
                            Navigator.pop(context);
                          }
                          setState(() {
                            isClick.fillRange(0, 3, true);
                            number = Random().nextInt(10);
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("知っていません"),
                        onPressed: () {
                          setState(() {
                            isClick.fillRange(0, 3, true);
                            number = Random().nextInt(10);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            );
            // ? KangiList()
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
