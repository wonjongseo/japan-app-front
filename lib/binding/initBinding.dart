import 'package:get/instance_manager.dart';
import 'package:japan_front/controller/kangiController.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(KangiController(), permanent: true);
  }
}
