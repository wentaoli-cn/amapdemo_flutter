import 'package:amap_demo/res/routes.dart';
import 'package:amap_demo/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.home,
      translations: Messages(),
      locale: View.of(context).platformDispatcher.locale,
      fallbackLocale: const Locale('en'),
      defaultTransition: Transition.cupertino,
      onInit: _onInit,
      onReady: _onReady,
      getPages: Routes.pages,
    );
  }

  void _onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  void _onReady() {
    Get.defaultDialog(
      title: Strings.commonAlert.name.tr,
      middleText: Strings.commonTip.name.tr,
      onConfirm: Get.back,
      confirmTextColor: Colors.white,
      textConfirm: Strings.commonOkay.name.tr,
    );
  }
}
