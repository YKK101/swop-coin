import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/providers/woo.dart';

class TokenListController extends GetxController with StateMixin<List<Token>> {
  static TokenListController get to => Get.find();

  final searchController = TextEditingController();
  final RxList<Token> availableTokenList = RxList.empty();

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
      availableTokenList(availableTokens);
    } catch (e) {
      change([], status: RxStatus.error());
    }
  }

  void updateSearchKeyword(String value) {
    List<Token> filterTokenList = availableTokenList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.protocol.toLowerCase().contains(value.toLowerCase()) ||
            element.token.toLowerCase().contains(value.toLowerCase()))
        .toList();
    change(filterTokenList, status: RxStatus.success());
  }
}
