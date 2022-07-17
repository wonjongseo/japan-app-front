import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/components/CAppber.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/model/enum/api_request_status.dart';
import 'package:japan_front/page/JlptKangiCards.dart';

class KangiPage extends GetView<KangiController> {
  final int level;
  KangiPage({Key? key, required this.level}) : super(key: key);
  ScrollController? _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        'N${level}',
      ),
      body: SafeArea(
          child: (controller.status[level] == ApiRequestStatus.loaded)
              ? Padding(
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
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.grey[300],
                            primary: Colors.grey[200],
                            elevation: 5.0,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      )
                                      // widget.parts?[index].last_index ==
                                      //         widget.parts?[index].kangis
                                      //             ?.length
                                      //     ? Icon(
                                      //         Icons.check_circle,
                                      //         color: Colors.green,
                                      //         size: 16,
                                      //       )
                                      //     : Icon(
                                      //         Icons.circle_outlined,
                                      //         size: 16,
                                      //       ),
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
                            print(index);
                            Get.to(() => JlptKangiCard(
                                level,
                                index,
                                controller.kangis[level]!
                                    .sublist(index, index + 15)));
                          },
                        ),
                      );
                    },
                    itemCount: (controller.kangis[level]!.length / 15).floor(),
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
