import 'package:get/instance_manager.dart';
import 'package:japan_front/controller/kangiController.dart';
import 'package:japan_front/controller/progressController.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(KangiController(), permanent: true);
    Get.put(ProgressController(), permanent: true);
  }
}
