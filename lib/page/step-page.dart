import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/components/CButton.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/page/JlptKangiCards.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Kangi.dart';

/*
  widget.firstWord != null ? 사전순  : JLPT
 */

// ignore: must_be_immutable
class StepPage extends StatefulWidget {
  final String appBarTitle;
  String? firstWord;
  StepPage({Key? key, required this.appBarTitle, this.firstWord})
      : super(key: key);

  @override
  State<StepPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StepPage> {
  late Future<List<Kangi>> kangis;
  late SharedPreferences _prefs;
  List<int> totalCount = [];
  List<String> lastIndex = [];

  ScrollController? _scrollController = ScrollController();

  Future<void> loadWords() async {
    kangis = widget.firstWord != null
        ? WordNetwork().getWords(http.Client(), widget.firstWord!)
        : WordNetwork().getKangisByLevel(http.Client(), widget.appBarTitle);
  }

  Future<void> getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    widget.firstWord != null
        ? lastIndex = _prefs.getStringList(widget.firstWord!)!
        : null;
  }

  @override
  void didUpdateWidget(covariant StepPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    widget.firstWord != null
        ? lastIndex = _prefs.getStringList(widget.firstWord!)!
        : null;
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    loadWords();
  }

  bool _isSuccess(int index) {
    return int.parse(lastIndex[index]) >= totalCount[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.firstWord != null
          ? getCustomAppBar(
              '${widget.appBarTitle}',
            )
          : getCustomAppBar('N${widget.appBarTitle}'),
      body: SafeArea(
        child: FutureBuilder<List<Kangi>>(
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              _getTotalCnt(snapshot.data!);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      child: ElevatedButton(
                        style: getCButtonStyle(),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: _isSuccess(index)
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 16,
                                    )
                                  ]),
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 27,
                                    color: Colors.black),
                              ),
                              Text(
                                '${lastIndex[index]}/${totalCount[index]}',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        )),
                        onPressed: () {
                          setState(() {
                            Get.to(() => widget.firstWord != null
                                ? WordCardPage(widget.appBarTitle, index,
                                    trimKangis(snapshot.data!, index), _prefs)
                                : WordCardPage('N${widget.appBarTitle}', index,
                                    trimKangis(snapshot.data!, index), _prefs));
                          });
                        },
                      ),
                    );
                  },
                  itemCount:
                      ((snapshot.data as List<Kangi>).length / 15).ceil(),
                ),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Error ${snapshot.error}'),
              );
            }

            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ]),
            );
          }),
          future: kangis,
        ),
      ),
    );
  }

  void _getTotalCnt(List data) {
    for (int i = 0; i < data.length / 15; i++) {
      if (i * 15 + 15 > data.length) {
        totalCount.add(data.length % 15);
      } else
        totalCount.add(15);
    }
  }

  List<Kangi> trimKangis(List<Kangi> kangi, int index) {
    if (index * 15 + 15 > kangi.length) {
      return kangi.sublist(index * 15);
    }
    return kangi.sublist(index * 15, index * 15 + 15);
  }
}
