import 'ad_config_production.dart';
import 'ad_config_test.dart';

class AdConfig {
  static const bool isProduction =
      bool.fromEnvironment('PRODUCTION_ADS', defaultValue: false);

  static String get bannerAdUnitId =>
      isProduction
          ? AdConfigProduction.bannerAdUnitId
          : AdConfigTest.bannerAdUnitId;

  static String get interstitialAdUnitId =>
      isProduction
          ? AdConfigProduction.interstitialAdUnitId
          : AdConfigTest.interstitialAdUnitId;
}