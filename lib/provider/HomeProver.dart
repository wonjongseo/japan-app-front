import 'package:flutter/material.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Level.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:japan_front/model/enum/api_request_status.dart';

class HomeProvider extends ChangeNotifier {
  late Map kangis;
  late Map progressing;
  late Level levels;

  void initServerData() async {
    try {
      HiveDB.instance.getLevelsData();
    } on Exception catch (e) {
      print(e);
    }
  }

  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;

  void getProgressing() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      progressing = HiveDB.instance.getProgressingAll();
      kangis = HiveDB.instance.getKangiAll();

      setApiRequestStatus(ApiRequestStatus.loaded);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  List getTotalCntOfLevel(int level) {
    print(progressing);
    return (progressing[level.toString()] as Progressing).step;
  }

  List getKangiByLevel(int level) {
    print('homeProvider : getKangiByLevel');

    return kangis.values
        .where((kangi) => int.parse(kangi.level) == level)
        .toList();
  }

  void changeStepByLevel(int level, int step, int currentStep) {
    HiveDB.instance.changeStepByLevel(level, step, currentStep);
    getProgressAndAlert();
  }

  void completePart(int level, int step) {
    HiveDB.instance.completePart(level, step);
    notifyListeners();
  }

  // Processing

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }

  void getProgressAndAlert() {
    progressing = HiveDB.instance.getProgressingAll();
    notifyListeners();
  }

  void addProgress(Progressing progressing) {
    // HiveDB.instance.addProgressing(progressing);
    getProgressAndAlert();
  }
}
