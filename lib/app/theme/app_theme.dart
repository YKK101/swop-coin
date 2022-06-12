import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swop_coin/app/theme/app_colors.dart';
import 'package:swop_coin/app/theme/app_dimension.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 0,
  ),
  textTheme: ThemeData().textTheme.copyWith(
        caption:
            ThemeData().textTheme.caption!.copyWith(color: Colors.grey[500]),
      ),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: Get.textTheme.caption!.copyWith(color: AppColors.errorColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }

        return AppColors.primaryColor;
      }),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimension.borderRadius),
        );
      }),
      minimumSize: MaterialStateProperty.resolveWith<Size?>((states) {
        return const Size.fromHeight(45);
      }),
    ),
  ),
);
