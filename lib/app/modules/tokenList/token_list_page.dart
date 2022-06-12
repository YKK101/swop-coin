import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/modules/tokenList/token_list_controller.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/theme/app_dimension.dart';

class TokenListPage extends GetWidget<TokenListController> {
  const TokenListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Token'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimension.spacing),
            child: TextFormField(
              controller: TokenListController.to.searchController,
              onChanged: TokenListController.to.updateSearchKeyword,
              decoration: const InputDecoration(
                hintText: 'Search',
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) => ListView.separated(
                itemCount: state!.length,
                itemBuilder: (ctx, idx) {
                  Token token = state[idx];
                  return GestureDetector(
                    onTap: () {
                      Get.back(result: token);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(AppDimension.spacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(token.token),
                          Text(token.protocol),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) => const Divider(),
              ),
              onEmpty: const Text('Empty'),
              onError: (_) => const Text('Error'),
              onLoading: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
