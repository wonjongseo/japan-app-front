import 'package:flutter/material.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/japanNetwork.dart';
import 'package:japan_front/components/Button.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/Kangi.dart';

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

  void _shoWMessage(Japan word) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              word.yomikata,
              style: TextStyle(fontSize: 17),
            ),
            content: Text(
              word.korea,
              style: TextStyle(fontSize: 15),
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
                        style: TextStyle(color: Colors.black),
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
                      style: getCButtonStyle(),
                      onPressed: () {
                        _shoWMessage(snapshot.data![index] as Japan);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '단어 ${index + 1}',
                                style: TextStyle(color: Colors.black),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star_border,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                          Text(
                            snapshot.data![index].japan,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          // ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.black,
                                  ),
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
