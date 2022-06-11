import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:swop_coin/app/modules/tokenList/token_list_controller.dart';
import 'package:swop_coin/app/models/token.dart';

class TokenListPage extends GetWidget<TokenListController> {
  const TokenListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) => ListView.separated(
          itemCount: state!.length,
          itemBuilder: (ctx, idx) {
            Token token = state[idx];
            return Column(
              children: [
                Text(token.token),
                Text(token.protocol),
              ],
            );
          },
          separatorBuilder: (ctx, idx) => const Divider(),
        ),
      ),
    );
  }
}
