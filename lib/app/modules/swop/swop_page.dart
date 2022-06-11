import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/modules/swop/components/token_dropdown.dart';
import 'package:swop_coin/app/modules/swop/swop_controller.dart';

class SwopPage extends StatelessWidget {
  const SwopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => TokenDropdown(
              data: SwopController.to.swopFrom.value,
              onChange: SwopController.to.updateSwopFrom,
            ),
          ),
          Obx(
            () => TokenDropdown(
              data: SwopController.to.swopTo.value,
              onChange: SwopController.to.updateSwopTo,
            ),
          ),
          IconButton(
            onPressed: () {
              SwopController.to.reverseSource();
            },
            icon: const Icon(Icons.swap_vertical_circle),
          )
        ],
      ),
    );
  }
}
