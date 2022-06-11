import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swop_coin/app/routes/app_pages.dart';
import 'package:swop_coin/app/routes/app_routes.dart';
import 'package:swop_coin/app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        theme: appTheme,
        getPages: AppPages.pages,
        initialRoute: Routes.initial,
      ),
    );
  }
}
