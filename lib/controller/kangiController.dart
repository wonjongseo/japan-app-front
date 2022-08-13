import 'package:get/get.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/wordNetwork.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/enum/api_request_status.dart';

class KangiController extends GetxController {
  static KangiController get to => Get.find();

  RxMap<String, List<Kangi>> kangis = Map<String, List<Kangi>>().obs;
  RxMap<String, ApiRequestStatus> status = Map<String, ApiRequestStatus>().obs;

  Future<void> loadKangisByLevel(String level) async {
    if (kangis[level] != null) return;

    status[level] = ApiRequestStatus.loading;

    try {
      await WordNetwork(Api.getKangisByJlptLevel)
          .getKangisByLevel(http.Client(), level)
          .then((value) {
        kangis[level] = value;
        status[level] = ApiRequestStatus.loaded;
      });

      print(kangis[level]);
    } on Exception catch (e) {
      print(e);
      return;
    }
  }
}
