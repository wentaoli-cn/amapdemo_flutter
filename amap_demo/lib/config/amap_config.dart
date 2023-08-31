import 'package:amap_flutter_base/amap_flutter_base.dart';

class AmapConfig {
  static const androidKey = '4734a22e5ff13a9b9a8b5c2a430eea12';
  static const iosKey = '8a2a3b0de7c70266188e5ed2ef152466';
  static const amapApiKey = AMapApiKey(iosKey: iosKey, androidKey: androidKey);
  static const amapPrivacyStatement =
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}
