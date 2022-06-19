import 'package:flutter/material.dart';

class KangiPage extends StatefulWidget {
  const KangiPage({Key? key}) : super(key: key);

  @override
  State<KangiPage> createState() => _KangiPageState();
}

class _KangiPageState extends State<KangiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        children: [Text('')],
      )),
    );
  }
}
