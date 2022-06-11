import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/routes/app_routes.dart';

class TokenDropdown extends StatelessWidget {
  const TokenDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: const [
            Text('Token'),
            Text('Network'),
          ],
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.tokenList);
          },
          icon: const Icon(Icons.navigate_next_rounded),
        ),
      ],
    );
  }
}
