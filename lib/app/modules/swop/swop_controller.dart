import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/constants/enum.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/providers/woo.dart';

class SwopController extends GetxController {
  static SwopController get to => Get.find();

  final status = RxStatus.empty().obs;
  final swopFrom = Token.fromJSON({
    "protocol": "ERC20",
    "token": "ETH",
    "name": "Ethereum",
  }).obs;
  final swopTo = Token.fromJSON({
    "protocol": "BTC",
    "token": "BTC",
    "name": "Bitcoin",
  }).obs;
  final swopRate = 1.0.obs;
  final fromBalance = 0.0.obs;
  final toBalance = 0.0.obs;
  final submitEnable = false.obs;

  final fromTextController = TextEditingController();
  final toTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<WooProvider>(() => WooProvider());
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      status(RxStatus.loading());
      await Future.wait([
        updateSwopRate(),
        updateBalance(SwopSide.from),
        updateBalance(SwopSide.to),
      ]);
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  void reverseSource() async {
    try {
      status(RxStatus.loading());
      Token tmpFrom = swopFrom.value;
      swopFrom(swopTo.value);
      swopTo(tmpFrom);
      clearAllTextInput();
      await Future.wait([
        updateSwopRate(),
        updateBalance(SwopSide.from),
        updateBalance(SwopSide.to),
      ]);
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  void updateSwopFrom(Token value) async {
    try {
      status(RxStatus.loading());
      swopFrom(value);
      await Future.wait([
        updateSwopRate(),
        updateBalance(SwopSide.from),
      ]);
      clearAllTextInput();
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  void updateSwopTo(Token value) async {
    try {
      status(RxStatus.loading());
      swopTo(value);
      await Future.wait([
        updateSwopRate(),
        updateBalance(SwopSide.to),
      ]);
      clearAllTextInput();
      status(RxStatus.success());
    } catch (e) {
      status(RxStatus.error());
    }
  }

  Future<void> updateSwopRate() async {
    try {
      double sr = await WooProvider.to
          .getSwopRate(swopFrom.value.token, swopTo.value.token);
      swopRate(sr);
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Can\'t get swap rate',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
      rethrow;
    }
  }

  Future<void> updateBalance(SwopSide side) async {
    try {
      String token =
          side == SwopSide.from ? swopFrom.value.token : swopTo.value.token;
      double balance = await WooProvider.to.getCurrentBalance(token);

      if (side == SwopSide.from) {
        fromBalance(balance);
      } else {
        toBalance(balance);
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Can\'t get current balance',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
      rethrow;
    }
  }

  void swopAsPercentage(double percentage) {
    fromTextController.text = (fromBalance.value * percentage / 100).toString();
    toTextController.text =
        (double.tryParse(fromTextController.text)! * swopRate.value).toString();
  }

  void clearAllTextInput() {
    fromTextController.text = '';
    toTextController.text = '';
    validateSubmitEnable();
  }

  void updateFromTextInput(String value) {
    try {
      double newValue = double.tryParse(value)!;
      if (fromValidator(value) == null) {
        double buyValue = newValue * swopRate.value;
        toTextController.text = buyValue.toPrecision(8).toString();
      } else {
        throw Error();
      }
    } catch (e) {
      toTextController.text = '';
    }
    validateSubmitEnable();
  }

  void updateToTextInput(String value) {
    try {
      double newValue = double.tryParse(value)!;

      if (toValidator(value) == null) {
        double sellValue = newValue / swopRate.value;
        fromTextController.text = sellValue.toPrecision(8).toString();
      } else {
        throw Error();
      }
    } catch (e) {
      fromTextController.text = '';
    }
    validateSubmitEnable();
  }

  String? fromValidator(String? value) {
    if (value == '') {
      return null;
    }

    double sellValue;
    try {
      sellValue = double.tryParse(value!)!;
    } catch (e) {
      return 'Input must be number';
    }

    if (sellValue <= 0) {
      return 'Sell value must bigger than 0';
    } else if (sellValue > fromBalance.value) {
      return 'Not enough balance';
    }

    return null;
  }

  String? toValidator(String? value) {
    if (value == '') {
      return null;
    }

    double buyValue;
    try {
      buyValue = double.tryParse(value!)!;
    } catch (e) {
      return 'Input must be number';
    }

    if (buyValue <= 0) {
      return 'Sell value must bigger than 0';
    }

    return null;
  }

  void validateSubmitEnable() {
    submitEnable(fromTextController.text != '' &&
        fromValidator(fromTextController.text) == null &&
        toValidator(toTextController.text) == null);
  }

  void submitSwop() {
    Get.defaultDialog(
      title: 'Success',
      middleText: 'Your transaction success',
      textConfirm: 'OK',
      onConfirm: () async {
        Get.back();
        clearAllTextInput();
        try {
          status(RxStatus.loading());
          await Future.wait([
            updateBalance(SwopSide.from),
            updateBalance(SwopSide.to),
          ]);
          status(RxStatus.success());
        } catch (e) {
          status(RxStatus.error());
        }
      },
    );
  }
}
