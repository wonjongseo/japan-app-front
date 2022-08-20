import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japan_front/api/baseNetwork.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaseController extends GetxController {
  // ----------------Setting ---------------------
  late SharedPreferences _prefs;

  Future<void> getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  BaseController() {
    getSharedPreferences();
  }

  void settingAllWordsAndCnt() async {
    BaseNetWork baseNetWork = new BaseNetWork();
    Map<String, dynamic> allWordsAndCnt =
        await baseNetWork.getAllWordsAndCnt(http.Client());

    allWordsAndCnt.forEach((firstWord, firstWordcnt) {
      if (_prefs.getStringList(firstWord) == null) {
        List<String> firstWordList = [];

        for (int i = 0; i < firstWordcnt / 15; i++) {
          firstWordList.add("0");
        }
        _prefs.setStringList(firstWord, firstWordList);
      }
    });
  }

  void deleteAllWordsAndCnt() async {
    print("deleting...");
    BaseNetWork baseNetWork = new BaseNetWork();
    Map<String, dynamic> allWordsAndCnt =
        await baseNetWork.getAllWordsAndCnt(http.Client());

    allWordsAndCnt.keys.forEach((firstName) {
      _prefs.remove(firstName);
    });
  }
}
