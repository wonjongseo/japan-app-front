import 'package:get/get.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/enum/api_request_status.dart';

class KangiController extends GetxController {
  static KangiController get to => Get.find();

  RxMap<int, List<Kangi>> kangis = Map<int, List<Kangi>>().obs;
  RxMap<int, ApiRequestStatus> status = Map<int, ApiRequestStatus>().obs;

  Future<void> loadKangisByLevel(int level) async {
    status[level] = ApiRequestStatus.loading;

    try {
      await KangiNetwork(Api.getKangisByJlptLevel)
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
