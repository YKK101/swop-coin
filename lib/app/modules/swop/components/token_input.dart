import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swop_coin/app/models/token.dart';
import 'package:swop_coin/app/modules/swop/components/token_dropdown.dart';
import 'package:swop_coin/app/theme/app_dimension.dart';

class TokenInput extends StatelessWidget {
  final String title;
  final TextEditingController? inputController;
  final Function(String)? onInputChanged;
  final String? Function(String?)? inputValidator;
  final double balance;
  final Token token;
  final Function(Token)? onTokenChanged;
  final bool enabled;

  const TokenInput({
    Key? key,
    this.title = '',
    this.inputController,
    this.onInputChanged,
    this.inputValidator,
    this.balance = 0,
    required this.token,
    this.onTokenChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: TextFormField(
                controller: inputController,
                onChanged: onInputChanged,
                validator: inputValidator,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('(\\d|\\.)')),
                ],
                enabled: enabled,
              ),
            ),
            SizedBox(
              width: AppDimension.spacing,
            ),
            TokenDropdown(
              data: token,
              onChange: onTokenChanged,
            ),
          ],
        ),
        Text('BALANCE $balance ${token.token}'),
      ],
    );
  }
}
