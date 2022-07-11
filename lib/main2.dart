import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/provider/HomeProver.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveDB.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback(
    //   (_) => Provider.of<HomeProvider>(context, listen: false).getProgressing(),
    // );
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('333');
  }

  int aaa = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeProvider homeProvider, child) {
      return Scaffold(
        body: Container(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(aaa.toString())]),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              // HiveDB.instance.deleteAll();
              homeProvider.initServerData();

              // homeProvider.getKangiByLevel(1);
            });
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
