import 'package:amap_demo/config/amap_config.dart';
import 'package:amap_demo/res/strings.dart';
import 'package:amap_demo/ui/base/base_view.dart';
import 'package:amap_demo/ui/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

class MapView extends BaseView<MapController> {
  const MapView({super.key});

  @override
  Widget builder(BuildContext context, MapController controller) {
    return Scaffold(
      appBar: _mapAppBar(),
      body: Center(child: _mapBody()),
      floatingActionButton: _mapFloatingActionButton(),
    );
  }

  PreferredSizeWidget _mapAppBar() {
    return AppBar(
      title: Text(Strings.mapTitle.name.tr),
      actions: [
        PopupMenuButton<MapType>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: MapType.normal,
              child: Text(Strings.mapNormalMap.name.tr),
            ),
            PopupMenuItem(
              value: MapType.satellite,
              child: Text(Strings.mapSatelliteMap.name.tr),
            ),
            PopupMenuItem(
              value: MapType.night,
              child: Text(Strings.mapNightMap.name.tr),
            ),
            PopupMenuItem(
              value: MapType.navi,
              child: Text(Strings.mapNavigationMap.name.tr),
            ),
            PopupMenuItem(
              value: MapType.bus,
              child: Text(Strings.mapBusMap.name.tr),
            ),
          ],
          onSelected: controller.changeMapType,
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }

  Widget _mapBody() {
    return Obx(() {
      final currentPosition = controller.currentPosition.value;

      if (currentPosition != null) {
        return AMapWidget(
          privacyStatement: AmapConfig.amapPrivacyStatement,
          apiKey: AmapConfig.amapApiKey,
          initialCameraPosition: currentPosition,
          mapType: controller.currentMapType.value,
          minMaxZoomPreference: MinMaxZoomPreference.defaultPreference,
          myLocationStyleOptions: MyLocationStyleOptions(true),
          markers: controller.currentMarkers.value,
          onMapCreated: controller.onMapCreated,
          onPoiTouched: controller.onPoiTouched,
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _mapFloatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.moveCameraToCurrent,
      child: const Icon(Icons.location_on),
    );
  }
}
