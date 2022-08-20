import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:japan_front/SharedPref.dart';
import 'package:japan_front/api/baseNetwork.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/controller/base-controller.dart';
import 'package:japan_front/controller/progressing-controller.dart';
import 'package:japan_front/page/Tt.dart';
import 'package:japan_front/page/n-level.dart';
import 'package:japan_front/screen/grammer/WordsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late SharedPreferences _prefs;

  BaseController baseController = new BaseController();

  int _selectedIdx = 0;

  Future<void> getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getKeys().toList().length == 0) {
      print("Setting..");
      baseController.settingAllWordsAndCnt();
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProgressingController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          baseController.deleteAllWordsAndCnt();
        },
        child: Icon(Icons.remove),
      ),
      body: WordsPage(),
    );
  }
}
