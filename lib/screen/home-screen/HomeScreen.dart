import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:japan_front/JlptLevel.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getProgressing(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          HiveDB.instance.deleteProgressingAll();
          HiveDB.instance.deleteKangisAll();
        }),
        child: Icon(Icons.add),
      ),
      appBar: getCustomAppBar('일본어 단어'),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(1),
            CustomButton(2),
            CustomButton(3),
            CustomButton(4),
            CustomButton(5),
          ],
        ),
      )),
    );
  }
}

class CustomButton extends StatefulWidget {
  final int level;
  CustomButton(this.level);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  int totalCnt = 0;
  Map? map;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeProvider homeProvider, child) {
      return Container(
        height: MediaQuery.of(context).size.height / 7,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => JlptLevel(widget.level.toString()))));
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8, left: 2, right: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  totalCnt == 0
                      ? Text('미학습')
                      : totalCnt == 1000
                          ? Text('학습 완료')
                          : Text('학습중'),
                  Text('N${widget.level}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        child: SliderTheme(
                          child: Slider(
                            // value: HiveDB.instance
                            //     .getProgressiveLevel(level.toString()),
                            value: double.parse(totalCnt.toString()),
                            max: 1000,
                            min: 0,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            onChanged: (double value) {},
                          ),
                          data: SliderTheme.of(context).copyWith(
                            // slider height
                            trackHeight: 10,
                            // remove padding
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0.0),
                          ),
                        ),
                      ),
                      Text(
                        '학습률: ${totalCnt} / 1000 [0%]',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            )),
      );
    });
  }
}
