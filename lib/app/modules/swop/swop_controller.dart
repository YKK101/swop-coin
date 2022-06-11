import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';

class SwopController extends GetxController {
  static SwopController get to => Get.find();

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

  void reverseSource() {
    Token tmpFrom = swopFrom.value;
    swopFrom(swopTo.value);
    swopTo(tmpFrom);
  }

  void updateSwopFrom(Token value) {
    swopFrom(value);
  }

  void updateSwopTo(Token value) {
    swopTo(value);
  }
}
