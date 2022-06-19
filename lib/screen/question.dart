import 'package:flutter/material.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:japan_front/network.dart';
import 'package:http/http.dart' as http;

class Question extends StatefulWidget {
  final String id;
  const Question({Key? key, required this.id}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
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
                            Text(snapshot.data![index].japan),
                            SizedBox(
                              width: 20,
                            ),
                            !isClickedMean[index]
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        print(isClickedMean[index]);
                                        isClickedMean[index] =
                                            !isClickedMean[index];
                                      });
                                    },
                                    child: Text("Mean"))
                                : Text(snapshot.data![index].korea),
                            SizedBox(
                              width: 20,
                            ),
                            !isClickedYomikata[index]
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        print(isClickedYomikata[index]);
                                        isClickedYomikata[index] =
                                            !isClickedYomikata[index];
                                      });
                                    },
                                    child: Text("Mean"))
                                : Text(snapshot.data![index].yomikata),
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
