import 'package:get/route_manager.dart';
import 'package:swop_coin/app/modules/swop/swop_binding.dart';
import 'package:swop_coin/app/modules/tokenList/token_list_binding.dart';
import 'package:swop_coin/app/modules/swop/swop_page.dart';
import 'package:swop_coin/app/modules/tokenList/token_list_page.dart';
import 'package:swop_coin/app/routes/app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.swop,
      page: () => const SwopPage(),
      binding: SwopBinding(),
    ),
    GetPage(
      name: Routes.tokenList,
      page: () => const TokenListPage(),
      binding: TokenListBinding(),
    ),
  ];
}
