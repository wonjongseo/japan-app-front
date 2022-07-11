import 'package:flutter/material.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Level.dart';
import 'package:japan_front/model/Part.dart';
import 'package:japan_front/model/enum/api_request_status.dart';

class HomeProvider extends ChangeNotifier {
  late Map<dynamic, Level> levels;

  void initServerData() async {
    try {
      HiveDB.instance.getLevelsData();
    } on Exception catch (e) {
      print(e);
    }
  }

  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;

  void getLevelBoxFromServer() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      levels = HiveDB.instance.getLevelsData() as Map<dynamic, Level>;

      print('levels ${levels}');
      setApiRequestStatus(ApiRequestStatus.loaded);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Map getLevels() {
    return levels;
  }

  // Processing

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }

  void getProgressAndAlert() {
    notifyListeners();
  }

  void addProgress() {
    // HiveDB.instance.addProgressing(progressing);
    getProgressAndAlert();
  }
}
