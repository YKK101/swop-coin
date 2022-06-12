import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/routes/app_routes.dart';
import 'package:swop_coin/app/theme/app_dimension.dart';

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
      child: SizedBox(
        width: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/coin-images/${data.token.toLowerCase()}.png',
              width: 32,
              height: 32,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/coin-images/dollar.png',
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(width: AppDimension.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.token,
                    style: Get.textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: AppDimension.spacing / 2),
                  Text(
                    data.protocol,
                    style: Get.textTheme.caption!.copyWith(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.navigate_next_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
