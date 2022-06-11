import 'package:flutter/material.dart';
import 'package:swop_coin/app/modules/swop/components/token_dropdown.dart';

class SwopPage extends StatelessWidget {
  const SwopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TokenDropdown(),
          TokenDropdown(),
        ],
      ),
    );
  }
}
