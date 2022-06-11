import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:swop_coin/app/modules/swop/components/token_dropdown.dart';
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
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: SwopController.to.fromTextController,
              onChanged: SwopController.to.updateFromTextInput,
              validator: SwopController.to.fromValidator,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('(\\d|\\.)')),
              ],
              enabled: SwopController.to.status.value.isLoading == false,
            ),
            Obx(() => Text(SwopController.to.fromBalance.value.toString())),
            Obx(
              () => TokenDropdown(
                data: SwopController.to.swopFrom.value,
                onChange: SwopController.to.updateSwopFrom,
              ),
            ),
            TextFormField(
              controller: SwopController.to.toTextController,
              onChanged: SwopController.to.updateToTextInput,
              validator: SwopController.to.toValidator,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('(\\d|\\.)')),
              ],
              enabled: SwopController.to.status.value.isLoading == false,
            ),
            Obx(() => Text(SwopController.to.toBalance.value.toString())),
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
            ),
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
      ),
    );
  }
}
