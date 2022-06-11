import 'package:get/instance_manager.dart';
import 'package:swop_coin/app/modules/tokenList/token_list_controller.dart';

class TokenListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TokenListController>(TokenListController());
  }
}
