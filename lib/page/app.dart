import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:japan_front/page/n-level.dart';
import 'package:japan_front/screen/grammer/WordsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  late SharedPreferences _prefs;
  Future<void> getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int _selectedIdx = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _selectedIdx = _tabController!.index;
      });
    });

    getSharedPreferences();
  }

  void start() {
    if (_prefs.getStringList("ga") == null) {
      List<String> ga = [];
      for (int i = 1; i < 24; i++) {
        print(i);
        ga.add("0");
      }
      _prefs.setStringList("ga", ga);
    }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [NLevelPage(), WordsPage()],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          start();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
              child: Text("JPLT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedIdx == 0 ? Colors.blue : Colors.black))),
          Tab(
              child: Text("사전순",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedIdx == 1 ? Colors.blue : Colors.black)))
        ],
        controller: _tabController,
      ),
    );
  }
}
