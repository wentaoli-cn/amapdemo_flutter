import 'dart:ui';
import 'package:amap_demo/res/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  void changeLanguage() {
    if (Get.locale?.languageCode == 'en') {
      Get.updateLocale(const Locale('zh'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  Future<void> navigateToLocationPage() async {
    if (await Permission.location.isGranted) {
      Get.toNamed(Routes.location);
    } else {
      Permission.location.request();
    }
  }

  Future<void> navigateToMapPage() async {
    if (await Permission.location.isGranted) {
      Get.toNamed(Routes.map);
    } else {
      Permission.location.request();
    }
  }
}
