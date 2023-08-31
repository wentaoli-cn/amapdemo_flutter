import 'package:amap_demo/ui/home/home_binding.dart';
import 'package:amap_demo/ui/home/home_view.dart';
import 'package:amap_demo/ui/location/location_binding.dart';
import 'package:amap_demo/ui/location/location_view.dart';
import 'package:amap_demo/ui/map/map_binding.dart';
import 'package:amap_demo/ui/map/map_view.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const location = '/location';
  static const map = '/map';

  static final pages = [
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: location,
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: map,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
  ];
}
