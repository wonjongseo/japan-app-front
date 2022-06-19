import 'package:flutter/material.dart';
import 'package:japan_front/screen/japanLevelPage.dart';
import 'package:japan_front/screen/japanPage.dart';
import 'package:japan_front/screen/kangiPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: BackButton(color: Colors.white),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        title: Text(
          'Japan Voca',
        ),
      ),
      body: TabBarView(
        children: [
          JapanPage(),
          KangiPage(),
        ],
        controller: _tabController,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            child: Text('Kangi'),
          ),
          Tab(
            child: Text('Kangi'),
          ),
        ],
        controller: _tabController,
        labelColor: Colors.white,
        indicatorColor: Colors.white,
      ),
    );
  }
}
