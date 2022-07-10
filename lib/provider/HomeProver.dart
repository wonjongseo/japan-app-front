import 'package:flutter/material.dart';
import 'package:japan_front/hive/hive_db.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:japan_front/model/enum/api_request_status.dart';

class HomeProvider extends ChangeNotifier {
  late List<Kangi> kangis;
  late Map<dynamic, Progressing> progressing;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;

  void getProgressing() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      progressing =
          HiveDB.instance.getProgressingAll() as Map<dynamic, Progressing>;

      if (progressing.isEmpty) {
        for (int j = 0; j < 5; j++) {
          for (int i = 0; i < 10; i++) {
            Progressing progressing =
                Progressing(level: j, step: List.filled(10, 0), step_range: 0);
            HiveDB.instance.addProgressing(progressing);
          }
        }
      }
      progressing.forEach(
        (key, value) {
          print('key : ${key} , value : ${value.level}');
        },
      );
      setApiRequestStatus(ApiRequestStatus.loaded);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }

  void getProgress() {
    progressing =
        HiveDB.instance.getProgressingAll() as Map<dynamic, Progressing>;
    notifyListeners();
  }

  void addProgress(Progressing progressing) {
    HiveDB.instance.addProgressing(progressing);
    getProgress();
  }
}
