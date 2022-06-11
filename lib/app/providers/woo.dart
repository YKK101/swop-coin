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

  Future<double> getSwopRate(String fromToken, String toToken) async {
    final Map<String, double> mock = {
      'SPOT_BTC_USDT': 28600.65,
      'SPOT_ETH_USDT': 1555.57,
      'SPOT_BNB_USDT': 275.2,
      'SPOT_SOL_USDT': 34.73,
      'SPOT_GAL_USDT': 3.248,
      'SPOT_ADA_USDT': 0.5684,
      'SPOT_SHIB_USDT': 0.00000960,
      'SPOT_AVAX_USDT': 21.01,
    };

    double fromToUSDT = mock['SPOT_${fromToken}_USDT'] ?? 1.5;
    double usdtToTo = 1 / (mock['SPOT_${toToken}_USDT'] ?? 1.5);

    await Future.delayed(const Duration(seconds: 1));
    return fromToUSDT * usdtToTo;
  }

  Future<double> getCurrentBalance(String token) async {
    final Map<String, double> mock = {
      'USDT': 5000,
      'BTC': 0.5,
      'ETH': 2,
      'BNB': 100,
      'SOL': 10.23,
      'GAL': 1000,
      'ADA': 500,
      'SHIB': 25000,
      'AVAX': 20,
    };

    await Future.delayed(const Duration(seconds: 1));
    return mock[token] ?? 0;
  }
}
