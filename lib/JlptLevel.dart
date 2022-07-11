import 'package:flutter/material.dart';
import 'package:japan_front/JlptKangiCards.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/enum/api_request_status.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:provider/provider.dart';

const int COUNT = 15;

class JlptLevel extends StatefulWidget {
  final String level;
  JlptLevel(this.level);

  @override
  State<JlptLevel> createState() => _JlptLevelState();
}

class _JlptLevelState extends State<JlptLevel> {
  ScrollController? _scrollController;
  List<Kangi>? kangisOFLevel;
  Map? progressing;

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController();

    _scrollController!.addListener((() {
      if (_scrollController!.offset >=
              _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        print('bottom');
        page++;
      }
    }));
    // _getProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, HomeProvider homeProvider, Widget? child) {
      List step_list = homeProvider.getTotalCntOfLevel(int.parse(widget.level));

      return Scaffold(
        appBar: getCustomAppBar(
          'N${widget.level}',
        ),
        body: SafeArea(
            child: (homeProvider.apiRequestStatus == ApiRequestStatus.loaded)
                ? Padding(
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
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.grey[300],
                              primary: Colors.grey[200],
                              elevation: 5.0,
                            ),
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        step_list[index] == COUNT
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 16,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                size: 16,
                                              ),
                                      ]),
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 27,
                                    ),
                                  ),
                                  Text('${step_list[index]}/${15}'),
                                ],
                              ),
                            )),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return JlptKangiCards(
                                    int.parse(widget.level), index + 1);
                              })));
                            },
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  )
                : CircularProgressIndicator()),
        // (homeProvider.apiRequestStatus == ApiRequestStatus.loading)

        // : ErrorLoadedWidget()),
      );
    });
  }
}
