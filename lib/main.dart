import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/JlptLevel.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/Related_Japan.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:japan_front/screen/home-screen/HomeScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // main 에서 비동기 사용
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveDB.init();

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
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.kToDark),
      ),
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        // RelatedJapan.id: (context) => RelatedJapan(),
      },
    );
  }
}
