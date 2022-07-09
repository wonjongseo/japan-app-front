import 'package:flutter/material.dart';

class Grammer {
  String grammer;
  String mean;
  String extand;
  String description;
  List<String> exam;

  Grammer(
      {required this.grammer,
      required this.mean,
      required this.exam,
      required this.description,
      required this.extand});
}

class GrammerLevel extends StatefulWidget {
  final int level;
  const GrammerLevel({Key? key, required this.level}) : super(key: key);

  @override
  State<GrammerLevel> createState() => _GrammerLevelState();
}

class _GrammerLevelState extends State<GrammerLevel> {
  List<Grammer> test = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState

    test.addAll([
      Grammer(
          grammer: "をめぐって1",
          mean: "~을 둘러싸고",
          exam: [
            "1人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・1",
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사"),
      Grammer(
          grammer: "をはじめ",
          mean: "~을 둘러싸고",
          exam: [
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사"),
      Grammer(
          grammer: "を問わず",
          mean: "~을 둘러싸고",
          exam: [
            "1人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・1",
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사"),
      Grammer(
          grammer: "割には",
          mean: "~을 둘러싸고",
          exam: [
            "1人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・1",
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사"),
      Grammer(
          grammer: "ようなら（ば）,ようであれ（ば）,ようだったら",
          mean: "~을 둘러싸고",
          exam: [
            "1人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・1",
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사"),
      Grammer(
          grammer: "ように",
          mean: "~을 둘러싸고",
          exam: [
            "1人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・1",
            "2人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・2",
            "3人気歌手の恋愛好かんドールを拭って様々な噂が飛び交っている・3",
          ],
          description: "물리적이 아닌 '논점 / 문재점 / 쟁점 등 추상적인 것을 둘러싸다'",
          extand: "명사")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grammer N${widget.level}'),
          backgroundColor: Colors.black,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext content) {
                      return GrammerDetail(grammer: test[index]);
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Card(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}:    ${test[index].grammer}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 1,
                        //   color: Colors.white,
                        // )
                      ],
                    ),
                  ),
                );
              },
              itemCount: test.length,
            ),
          ),
        ));
  }
}

class GrammerDetail extends StatefulWidget {
  final Grammer grammer;

  const GrammerDetail({Key? key, required this.grammer}) : super(key: key);

  @override
  State<GrammerDetail> createState() => _GrammerDetailState();
}

class _GrammerDetailState extends State<GrammerDetail> {
  List<bool> isButtonClick = List.filled(2, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grammer.grammer),
        backgroundColor: Colors.black,
      ),
      body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("意味"),
                      !isButtonClick[0]
                          ? TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: EdgeInsets.zero, // and this
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              onPressed: () {
                                setState(() {
                                  isButtonClick[0] = !isButtonClick[0];
                                });
                              },
                              child: Text("Click"))
                          : Text(widget.grammer.mean)
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("接続"),
                      !isButtonClick[1]
                          ? TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: EdgeInsets.zero, // and this
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              onPressed: () {
                                setState(() {
                                  isButtonClick[1] = !isButtonClick[1];
                                });
                              },
                              child: Text("Click"))
                          : Text(widget.grammer.extand)
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("例"),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(widget.grammer.exam[index]),
                      );
                    }),
                    itemCount: widget.grammer.exam.length,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
              ],
            ),
          )),
    );
  }
}
