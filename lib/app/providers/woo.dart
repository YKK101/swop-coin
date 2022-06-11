import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';

class WooProvider extends GetConnect {
  static WooProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://api.staging.woo.org'; // FIXME: move to Config
  }

  Future<List<Token>> getAvailableTokens() async {
    Response res = await get('/v1/public/token_network');

    if (res.body['success'] == true) {
      return (res.body['rows'] as List)
          .map((json) => Token.fromJSON(json))
          .toList();
    } else {
      throw Error();
    }
  }
}
