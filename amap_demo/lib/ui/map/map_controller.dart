import 'dart:async';
import 'dart:io';

import 'package:amap_demo/config/amap_config.dart';
import 'package:amap_demo/res/strings.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends GetxController {
  final _locationRepository = AMapFlutterLocation();

  final currentPosition = Rx<CameraPosition?>(null);

  final currentMapType = Rx<MapType>(MapType.normal);

  final currentMarkers = Rx<Set<Marker>>({});

  late StreamSubscription<Map<String, Object>> _locationInformationListener;

  late AMapController _mapController;

  @override
  void onInit() {
    super.onInit();

    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    AMapFlutterLocation.setApiKey(AmapConfig.androidKey, AmapConfig.iosKey);

    _locationInformationListener =
        _locationRepository.onLocationChanged().listen(
      (Map<String, Object> result) {
        final latitude = double.tryParse(result['latitude'].toString());
        final longitude = double.tryParse(result['longitude'].toString());

        if (latitude != null && longitude != null) {
          currentPosition.value = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 17,
          );
        }
      },
    );
    locate();
  }

  Future<void> locate() async {
    final currentLanguageCode = Get.locale?.languageCode;
    final currentAccuracy =
        await _locationRepository.getSystemAccuracyAuthorization();

    _locationRepository.setLocationOption(AMapLocationOption(
      locationInterval: 30000,
      needAddress: false,
      geoLanguage:
          currentLanguageCode == 'en' ? GeoLanguage.EN : GeoLanguage.ZH,
      desiredLocationAccuracyAuthorizationMode: currentAccuracy ==
              AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy
          ? AMapLocationAccuracyAuthorizationMode.FullAccuracy
          : AMapLocationAccuracyAuthorizationMode.ReduceAccuracy,
    ));
    _locationRepository.startLocation();
  }

  void onMapCreated(AMapController controller) {
    _mapController = controller;
  }

  void onPoiTouched(AMapPoi poi) {
    final currentPositionValue = currentPosition.value;
    final poiLatLng = poi.latLng;

    if (currentPositionValue != null && poiLatLng != null) {
      currentMarkers.value.clear();
      currentMarkers.value = {Marker(position: poiLatLng)};

      Get.snackbar(
        poi.name.toString(),
        Strings.mapTip.name.tr,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (_) async {
          final url = Uri.parse(Platform.isAndroid
              ? 'amapuri://route/plan/?'
                  '&dlat=${poiLatLng.latitude}'
                  '&dlon=${poiLatLng.longitude}'
                  '&dev=0&t=2'
              : 'iosamap://path?'
                  '&dlat=${poiLatLng.latitude}'
                  '&dlon=${poiLatLng.longitude}'
                  '&dev=0&t=2');

          try {
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              Get.snackbar(
                Strings.commonError.name.tr,
                Strings.mapDidNotFindAmap.name.tr,
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                animationDuration: const Duration(milliseconds: 500),
              );
            }
          } catch (e) {
            // Do nothing
          } finally {
            currentMarkers.value.clear();
          }
        },
      );
    }
  }

  void changeMapType(MapType mapType) {
    if (currentMapType.value != mapType) {
      currentMapType.value = mapType;
    }
  }

  void moveCameraToCurrent() {
    final currentPositionValue = currentPosition.value;

    if (currentPositionValue != null) {
      _mapController.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: currentPositionValue.target,
          zoom: 20,
        )),
        duration: 500,
      );
    }
  }

  @override
  void onClose() {
    _locationInformationListener.cancel();
    _locationRepository.destroy();

    _mapController.disponse();

    super.onClose();
  }
}
