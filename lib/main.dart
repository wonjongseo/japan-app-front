import 'package:flutter/material.dart';
import 'package:japan_front/model/Custom_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Database database
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = CustomDatabase().initDatabase();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: "/",
      routes: {"/": ((context) => MainPage(database))},
    );
  }
}

class MainPage extends StatefulWidget {
  final Future<Database> db;
  MainPage(this.db);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _value = 0.4;

  // void _setvalue(double value) => setState(() => _value = value);

  @override
  void initState() {
    print('???');
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAA();
  }

  void getAA() async {
    print('object');
    List<Progressing> list = await CustomDatabase().getProgressing(widget.db);
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      print('i : ${i}');
      print('range : ${list[i].range}');
      print('level : ${list[i].level}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: Icon(Icons.settings),
          centerTitle: false,
          title: Text(
            "일본어 단어",
            style: TextStyle(),
          ),
        ),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            drawButton(context, '1'),
            drawButton(context, '2'),
            drawButton(context, '3'),
            drawButton(context, '4'),
            drawButton(context, '5')
          ],
        ),
      )),
    );
  }

  // 버튼 위젯
  Widget drawButton(BuildContext context, String level) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => Text("asd"))));
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
                          value: 50,
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

/*
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Japanese App",
      initialRoute: "/",
      routes: {"/": ((context) => MainPage())},
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

// 버튼 위젯
Widget drawButton(BuildContext context, String level) {
  return Container(
    height: MediaQuery.of(context).size.height / 7,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8, left: 2, right: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text('미학습'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text('N${level}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 180,
                    child: SliderTheme(
                      child: Slider(
                        value: 50,
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

class _MainPageState extends State<MainPage> {
  double _value = 0.4;

  void _setvalue(double value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: Icon(Icons.settings),
          centerTitle: false,
          title: Text(
            "일본어 단어",
          ),
        ),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            drawButton(context, '1'),
            drawButton(context, '2'),
            drawButton(context, '3'),
            drawButton(context, '4'),
            drawButton(context, '5')
          ],
        ),
      )),
    );
  }
}

 
 */