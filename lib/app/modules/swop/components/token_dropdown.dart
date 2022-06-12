import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/routes/app_routes.dart';

class TokenDropdown extends StatelessWidget {
  final Token data;
  final Function(Token value)? onChange;

  const TokenDropdown({
    Key? key,
    required this.data,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selected = await Get.toNamed(Routes.tokenList);
        if (selected != null) {
          onChange?.call(selected);
        }
      },
      child: Row(
        children: [
          Column(
            children: [
              Text(data.token),
              Text(data.protocol),
            ],
          ),
          const Icon(Icons.navigate_next_rounded),
        ],
      ),
    );
  }
}
