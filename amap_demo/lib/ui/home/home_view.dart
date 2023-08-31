import 'package:amap_demo/res/strings.dart';
import 'package:amap_demo/ui/base/base_view.dart';
import 'package:amap_demo/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeController controller) {
    return Scaffold(
      appBar: _homeViewAppBar(),
      body: Center(child: _homeBody()),
    );
  }

  PreferredSizeWidget _homeViewAppBar() {
    return AppBar(
      title: Text(Strings.homeTitle.name.tr),
      actions: [
        IconButton(
          onPressed: controller.changeLanguage,
          icon: const Icon(Icons.translate),
        )
      ],
    );
  }

  Widget _homeBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: controller.navigateToLocationPage,
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(.0),
          ),
          child: Text(Strings.homeNavigateToLocationButton.name.tr),
        ),
        ElevatedButton(
          onPressed: controller.navigateToMapPage,
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(.0),
          ),
          child: Text(Strings.homeNavigateToMapButton.name.tr),
        ),
      ],
    );
  }
}
