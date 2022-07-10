import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/JlptKangiCards.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/error_widget.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:japan_front/model/enum/api_request_status.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:provider/provider.dart';

class JlptLevel extends StatefulWidget {
  final String level;
  JlptLevel(this.level);

  @override
  State<JlptLevel> createState() => _JlptLevelState();
}

class _JlptLevelState extends State<JlptLevel>
    with AutomaticKeepAliveClientMixin {
  DateTime currentBackPressTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgress();
  }

  @override
  bool get wantKeepAlive => true;

  void _getProgress() async {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getProgressing(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget? child) =>
              Scaffold(
        appBar: getCustomAppBar(
          'N${widget.level}',
        ),
        body: SafeArea(
            child: (homeProvider.apiRequestStatus == ApiRequestStatus.loaded)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
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
                                        false
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
                                  Text('0/15'),
                                ],
                              ),
                            )),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return JlptKangiCards(
                                    int.parse(widget.level), index + 1);
                              })));
                              // HiveDB.instance.addToProgressive(
                              //   widget.level,
                              // );
                            },
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  )
                : (homeProvider.apiRequestStatus == ApiRequestStatus.loading)
                    ? CircularProgressIndicator()
                    : ErrorLoadedWidget()),
      ),
    );
  }
}
