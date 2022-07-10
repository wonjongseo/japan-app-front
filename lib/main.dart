import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/JlptLevel.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // main 에서 비동기 사용
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveDB.init();
  // runApp(MyApp());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // Database database
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.kToDark),
      ),
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: "/",
      routes: {"/": ((context) => MainPage())},
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          HiveDB.instance.deleteProgressingAll();
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

class CustomButton extends StatelessWidget {
  final int level;

  CustomButton(this.level);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => JlptLevel(level.toString()))));
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 2, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('미학습'),
                Text('N${level}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: SliderTheme(
                        child: Slider(
                          // value: HiveDB.instance
                          //     .getProgressiveLevel(level.toString()),
                          value: 0,
                          max: 100,
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
                      '학습률: 0 / 1000 [0%]',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
