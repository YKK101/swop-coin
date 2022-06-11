import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/providers/woo.dart';

class TokenListController extends GetxController with StateMixin<List<Token>> {
  static TokenListController get to => Get.find();

  List<Token> availableTokens = RxList.empty();

  @override
  void onInit() {
    super.onInit();

    Get.lazyPut<WooProvider>(() => WooProvider());

    fetchAvailableTokens();
  }

  void fetchAvailableTokens() async {
    try {
      change([], status: RxStatus.loading());
      List<Token> availableTokens = await WooProvider.to.getAvailableTokens();
      change(availableTokens, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error());
    }
  }
}
