import 'package:flutter/material.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/japanNetwork.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:http/http.dart' as http;

class RelatedJapan extends StatefulWidget {
  static const id = 'RelatedJapan';
  final String kangi_level;

  RelatedJapan(this.kangi_level);

  @override
  State<RelatedJapan> createState() => _RelatedJapanState();
}

class _RelatedJapanState extends State<RelatedJapan> {
  Future<List<Japan>>? futureJapans;
  late List<bool> isClickedMean;
  late List<bool> isClickedYomikata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRelatedJapan();
  }

  Future<void> getRelatedJapan() async {
    futureJapans = JapanNetwork(Api.getJapansByKangiId)
        .getJapansByKangiId(http.Client(), widget.kangi_level);

    futureJapans!.then((value) => {
          isClickedYomikata = List<bool>.filled(value.length, false),
          isClickedMean = List<bool>.filled(value.length, false),
        });
  }

  Widget isLongerThen13Word(String word) {
    return word.length >= 13
        ? TextButton(
            onPressed: () {
              print(word);
              _shoWMessage(word);
            },
            child: Text(word.substring(0, 13) + "..."),
          )
        : Text(
            word,
            style: TextStyle(color: Colors.pink),
          );
  }

  void _shoWMessage(String word) {
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
      appBar: getCustomAppBar(widget.kangi_level),
      body: FutureBuilder<List<Japan>>(
        future: futureJapans,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 7,
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('단어 ${index + 1}'),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.star_border))
                            ],
                          ),
                          Text(
                            snapshot.data![index].japan,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          // ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.volume_up_rounded),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                                )
                              ]),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
