import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/components/Button.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/model/enum/api_request_status.dart';
import 'package:japan_front/page/JlptKangiCards.dart';

import '../model/Kangi.dart';

class KangiPage extends GetView<KangiController> {
  final String level;
  List<Kangi>? kangis;
  KangiPage({Key? key, required this.level, this.kangis}) : super(key: key);
  ScrollController? _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        '${level}',
      ),
      body: SafeArea(
          child: kangis != null
              ? _Screen(kangis)
              : (controller.status[level] == ApiRequestStatus.loaded)
                  ? _Screen(controller.kangis[level])
                  : CircularProgressIndicator()),
    );
  }

  Widget _Screen(List<Kangi>? kangis) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return Container(
            child: ElevatedButton(
              style: getCButtonStyle(),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      )
                    ]),
                    Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                      ),
                    ),
                    Text('')
                    // Text('${0}/${controller.kangis[level]!.length}')
                  ],
                ),
              )),
              onPressed: () {
                Get.to(
                    () => JlptKangiCard(1, index, trimKangis(kangis!, index)));
              },
            ),
          );
        },
        itemCount: (kangis!.length / 15).ceil(),
      ),
    );
  }

  List<Kangi> trimKangis(List<Kangi> kangi, int index) {
    if (index * 15 + 15 > kangi.length) {
      return kangi.sublist(index * 15);
    }

    return kangi.sublist(index * 15, index * 15 + 15);
  }
}
