import 'package:flutter/material.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;

class RelatedJapan extends StatefulWidget {
  final String id;
  const RelatedJapan({Key? key, required this.id}) : super(key: key);

  @override
  State<RelatedJapan> createState() => _RelatedJapanState();
}

class _RelatedJapanState extends State<RelatedJapan> {
  late Future<List<Japan>> futureJapans;

  @override
  void initState() {
    super.initState();
    getJapan();
  }

  late List<bool> isClickedMean;
  late List<bool> isClickedYomikata;

  void getJapan() {
    Network network = Network("http://localhost:4000/japans");
    futureJapans = network.fetchJapans(http.Client(), widget.id);
    futureJapans.then((value) => {
          isClickedYomikata = List<bool>.filled(value.length, false),
          isClickedMean = List<bool>.filled(value.length, false),
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
            print("herer ??");

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
                              width: 80,
                              child: Text(
                                snapshot.data![index].japan,
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 20),
                              ),
                            ),
                            Container(
                                width: 150,
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
                                          child: Text("Mean",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        )
                                      : Text(
                                          snapshot.data![index].korea,
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                )),
                            Container(
                                width: 80,
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
                                            "Mean",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ))
                                      : Text(
                                          snapshot.data![index].yomikata,
                                          style: TextStyle(
                                              color: Colors.pink, fontSize: 20),
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
