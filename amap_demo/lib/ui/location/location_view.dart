import 'package:amap_demo/model/ui/location_information.dart';
import 'package:amap_demo/res/strings.dart';
import 'package:amap_demo/ui/base/base_view.dart';
import 'package:amap_demo/ui/location/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationView extends BaseView<LocationController> {
  const LocationView({super.key});

  @override
  Widget builder(BuildContext context, LocationController controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.locationTitle.name.tr),
      ),
      body: Center(child: _locationBody()),
    );
  }

  Widget _locationBody() {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: controller.locate,
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(.0),
          ),
          child: Text(Strings.locationLocateButton.name.tr),
        ),
        ElevatedButton(
          onPressed: controller.stopLocating,
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(.0),
          ),
          child: Text(Strings.locationStopLocatingButton.name.tr),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Obx(() {
          if (controller.currentLocationInformation.value != null) {
            return Expanded(
              child: _locationInformationCard(
                  controller.currentLocationInformation.value),
            );
          } else {
            return Text(Strings.locationTip.name.tr);
          }
        }),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget _locationInformationCard(LocationInformation? locationInformation) {
    return ListView(
      children: [
        _locationInformationItem(
          description: Strings.locationTime.name.tr,
          data: locationInformation?.time.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationLatitude.name.tr,
          data: locationInformation?.latitude.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationLongitude.name.tr,
          data: locationInformation?.longitude.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationAccuracy.name.tr,
          data: locationInformation?.accuracy.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationCountry.name.tr,
          data: locationInformation?.country.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationProvince.name.tr,
          data: locationInformation?.province.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationCity.name.tr,
          data: locationInformation?.city.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationCityCode.name.tr,
          data: locationInformation?.cityCode.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationDistrict.name.tr,
          data: locationInformation?.district.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationDistrictCode.name.tr,
          data: locationInformation?.districtCode.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationStreet.name.tr,
          data: locationInformation?.streetNumber.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationStreetNumber.name.tr,
          data: locationInformation?.streetNumber.toString(),
        ),
        _locationInformationItem(
          description: Strings.locationDescription.name.tr,
          data: locationInformation?.description.toString(),
        ),
      ],
    );
  }

  Widget _locationInformationItem({required String description, String? data}) {
    final descriptionArgument =
        (data != null && data.isNotEmpty && data != 'null')
            ? data
            : Strings.commonFailToGetInformation.name.tr;

    return Text(
      description.trArgs([descriptionArgument]),
      textAlign: TextAlign.center,
    );
  }
}
