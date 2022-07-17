import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:japan_front/controller/progressController.dart';
import 'package:japan_front/page/Related_Japan.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/constants/configs.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class JlptKangiCard extends StatefulWidget {
  final int level;
  final int step;
  List<Kangi>? kangis;

  JlptKangiCard(this.level, this.step, this.kangis);

  @override
  State<JlptKangiCard> createState() => _JlptKangiCardState();
}

class _JlptKangiCardState extends State<JlptKangiCard> {
  List<bool> isButtonClick = List.filled(3, false);
  int index = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    // ProgressController.to.save(widget.level, widget.step);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar('N${widget.level} - Part${widget.step}'),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1}/${widget.kangis?.length}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        ElevatedButton(
                          child: Text("연관 단어"),
                          style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RelatedJapan(widget.kangis![index].id);
                            }));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.kangis![index].japan,
                              style: kangiTextStyle,
                            ),
                          ],
                        ),
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isButtonClick[0] = true;
                                      });
                                    },
                                    style: correctButtonStyle,
                                    child: Text(
                                      '음독',
                                    )),
                                !isButtonClick[0]
                                    ? Text("")
                                    : Container(
                                        child:
                                            Text(widget.kangis![index].undoc),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isButtonClick[1] = true;
                                      });
                                    },
                                    style: correctButtonStyle,
                                    child: Text(
                                      '훈독',
                                    )),
                                !isButtonClick[1]
                                    ? Text("")
                                    : Container(
                                        child:
                                            Text(widget.kangis![index].hundoc),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isButtonClick[2] = true;
                                      });
                                    },
                                    style: correctButtonStyle,
                                    child: Text(
                                      '의미',
                                    )),
                                !isButtonClick[2]
                                    ? Text("")
                                    : Container(
                                        child:
                                            Text(widget.kangis![index].korea),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (index + 1 == widget.kangis!.length) {
                                      return Navigator.of(context).pop();
                                    }
                                    setState(() {
                                      index++;
                                    });
                                  },
                                  child: Text('알고 있습니다.'),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (index + 1 == widget.kangis!.length) {
                                        return Navigator.of(context).pop();
                                      }

                                      setState(() {
                                        ProgressController.to.addUnknownKangi(
                                            widget.kangis![index],
                                            widget.level,
                                            widget.step);
                                        index++;
                                      });
                                    },
                                    child: Text('모르겠습니다.')),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
