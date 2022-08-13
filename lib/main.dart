import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/Palette.dart';
import 'package:japan_front/binding/initBinding.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/page/app.dart';

void main() async {
  // main 에서 비동기 사용
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveDB.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // darkTheme: ThemeData.dark(),

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.kToDark),
      // ),
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: false,
      title: "WJS Japan Voca``",
      initialBinding: InitBinding(),
      home: App(),
    );
  }
}
