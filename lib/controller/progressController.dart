import 'dart:math';

import 'package:get/get.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/enum/api_request_status.dart';

class ProgressController extends GetxController {
  static ProgressController get to => Get.find();

  RxMap<int, Map<int, List<int>>> progress =
      Map<int, Map<int, List<int>>>().obs;

  // RxList<Kangi> unKnownKangis = RxList<Kangi>.empty(growable: true);
  RxMap<String, List<Kangi>> unKnownKangis = RxMap<String, List<Kangi>>();

  static Future<void> init() async {}

  void addUnknownKangi(Kangi kangi, int level, int step) {
    String key = _makeKey(level, step);

    if (unKnownKangis[key] == null) {
      unKnownKangis[key] = List.empty(growable: true);
    }
    unKnownKangis[key]?.add(kangi);
  }

  String _makeKey(int level, int step) {
    return '${level}-${step}';
  }

  List<Kangi>? getUnknownKangi(String key) {
    return unKnownKangis.value[key];
  }

  void save(int level, int step) {
    String key = _makeKey(level, step);
    List<Kangi>? kangis = getUnknownKangi(key);
    HiveDB.instance.saveKangis(key, kangis!);
  }
}
