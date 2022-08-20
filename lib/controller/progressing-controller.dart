import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProgressingController extends GetxController {
  Map<String, List<String>> progressing = {};

  Map<String, List<String>> totalCnt = {};

  void setTotalCnt() {
    totalCnt = {
      "n1": new List.filled(22, "0"),
      "n2": new List.filled(22, "0"),
      "n3": new List.filled(20, "0"),
      "n4": new List.filled(25, "0"),
      "n5": new List.filled(22, "0"),
      "ga": new List.filled(23, "0"),
      "na": new List.filled(2, "0"),
      "da": new List.filled(7, "0"),
      "ra": new List.filled(8, "0"),
      "ma": new List.filled(8, "0"),
      "ba": new List.filled(12, "0"),
      "sa": new List.filled(19, "0"),
      "a": new List.filled(16, "0"),
      "ja": new List.filled(15, "0"),
      "tya": new List.filled(15, "0"),
      "ka": new List.filled(1, "0"),
      "ta": new List.filled(4, "0"),
      "pa": new List.filled(5, "0"),
      "ha": new List.filled(11, "0"),
      "acc": new List.filled(1, "0"),
    };
  }

  void setProgressing(String key, List<String> list) {
    progressing[key] = list;
  }

  List<String> getProgressing(String key) {
    return progressing[key]!;
  }

  void increate(String key, int index, String next) {
    if (progressing[key] != null && int.parse(progressing[key]![index]) < 15) {
      progressing[key]![index] = next;
      update();
    }
  }

  void reset(String key, int index) {
    if (progressing[key] != null) {
      progressing[key]![index] = "0";
      update();
    }
  }
}
