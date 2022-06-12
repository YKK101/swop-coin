import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/components/expandable_scroll_view.dart';
import 'package:swop_coin/app/modules/swop/components/token_input.dart';
import 'package:swop_coin/app/modules/swop/swop_controller.dart';

class SwopPage extends StatelessWidget {
  const SwopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap'),
        centerTitle: true,
      ),
      body: ExpandableScrollView(
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Obx(
                  () => SizedBox(
                    height: 100,
                    child: TokenInput(
                      title: 'YOU PAY',
                      inputController: SwopController.to.fromTextController,
                      onInputChanged: SwopController.to.updateFromTextInput,
                      inputValidator: SwopController.to.fromValidator,
                      enabled:
                          SwopController.to.status.value.isLoading == false,
                      token: SwopController.to.swopFrom.value,
                      onTokenChanged: SwopController.to.updateSwopFrom,
                      balance: SwopController.to.fromBalance.value,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SwopController.to.reverseSource();
                  },
                  icon: const Icon(Icons.swap_vertical_circle),
                ),
                Obx(
                  () => SizedBox(
                    height: 100,
                    child: TokenInput(
                      title: 'YOU GET',
                      inputController: SwopController.to.toTextController,
                      onInputChanged: SwopController.to.updateToTextInput,
                      inputValidator: SwopController.to.toValidator,
                      enabled:
                          SwopController.to.status.value.isLoading == false,
                      token: SwopController.to.swopTo.value,
                      onTokenChanged: SwopController.to.updateSwopTo,
                      balance: SwopController.to.toBalance.value,
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        SwopController.to.swopAsPercentage(100);
                      },
                      child: const Text('100%'),
                    ),
                    TextButton(
                      onPressed: () {
                        SwopController.to.swopAsPercentage(50);
                      },
                      child: const Text('50%'),
                    ),
                    TextButton(
                      onPressed: () {
                        SwopController.to.swopAsPercentage(25);
                      },
                      child: const Text('25%'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              Obx(
                () => Text(
                  '1 ${SwopController.to.swopFrom.value.token} = ${SwopController.to.swopRate.value} ${SwopController.to.swopTo.value.token}',
                ),
              ),
              Obx(
                () => SwopController.to.status.value.isLoading
                    ? const CircularProgressIndicator()
                    : const SizedBox(),
              ),
              Obx(
                () => TextButton(
                  onPressed: SwopController.to.submitEnable.value == true
                      ? SwopController.to.submitSwop
                      : null,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
