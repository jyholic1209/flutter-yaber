import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
