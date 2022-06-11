import 'package:get/instance_manager.dart';
import 'package:swop_coin/app/modules/swop/swop_controller.dart';

class SwopBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SwopController());
  }
}
