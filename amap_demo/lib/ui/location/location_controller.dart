import 'dart:async';

import 'package:amap_demo/config/amap_config.dart';
import 'package:amap_demo/model/ui/location_information.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final _locationRepository = AMapFlutterLocation();

  final currentLocationInformation = Rx<LocationInformation?>(null);

  late StreamSubscription<Map<String, Object>> _locationInformationListener;

  @override
  void onInit() {
    super.onInit();

    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    AMapFlutterLocation.setApiKey(AmapConfig.androidKey, AmapConfig.iosKey);

    _locationInformationListener =
        _locationRepository.onLocationChanged().listen(
      (Map<String, Object> result) {
        currentLocationInformation.value = LocationInformation(
          time: DateTime.tryParse(result['locationTime'].toString()),
          latitude: double.tryParse(result['latitude'].toString()),
          longitude: double.tryParse(result['longitude'].toString()),
          accuracy: double.tryParse(result['accuracy'].toString()),
          country: result['country'].toString(),
          province: result['province'].toString(),
          city: result['city'].toString(),
          cityCode: result['cityCode'].toString(),
          district: result['district'].toString(),
          districtCode: result['adCode'].toString(),
          street: result['street'].toString(),
          streetNumber: result['streetNumber'].toString(),
          description: result['description'].toString(),
        );
      },
    );
  }

  Future<void> locate() async {
    final currentLanguageCode = Get.locale?.languageCode;
    final currentAccuracy =
        await _locationRepository.getSystemAccuracyAuthorization();

    _locationRepository.setLocationOption(AMapLocationOption(
      geoLanguage:
          currentLanguageCode == 'en' ? GeoLanguage.EN : GeoLanguage.ZH,
      desiredLocationAccuracyAuthorizationMode: currentAccuracy ==
              AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy
          ? AMapLocationAccuracyAuthorizationMode.FullAccuracy
          : AMapLocationAccuracyAuthorizationMode.ReduceAccuracy,
    ));
    _locationRepository.startLocation();
  }

  void stopLocating() => _locationRepository.stopLocation();

  @override
  void onClose() {
    _locationInformationListener.cancel();
    _locationRepository.destroy();

    super.onClose();
  }
}
