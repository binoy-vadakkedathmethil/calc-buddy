import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_config.dart';

class InterstitialAdManager {
  InterstitialAdManager._();

  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  // Show an interstitial every 3rd calculation.
  static const int _showAdEvery = 3;

  static int _calculationCount = 0;


  static void loadAd() {
    if (_isLoading || _interstitialAd != null) {
      return;
    }

    _isLoading = true;

    InterstitialAd.load(
      adUnitId: AdConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoading = false;
          _interstitialAd = ad;

          debugPrint('Interstitial ad loaded.');

          ad.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Interstitial ad dismissed.');

              ad.dispose();
              _interstitialAd = null;

              loadAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint(
                'Interstitial failed to show: $error',
              );

              ad.dispose();
              _interstitialAd = null;

              loadAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _interstitialAd = null;

          debugPrint(
            'Interstitial failed to load: $error',
          );
        },
      ),
    );
  }

  static void recordCalculation() {
    _calculationCount++;

    debugPrint(
      'Calculation count: $_calculationCount',
    );

    if (_calculationCount >= _showAdEvery) {
      _calculationCount = 0;

      showAd();
    }
  }

  static void showAd() {
    final ad = _interstitialAd;

    if (ad == null) {
      debugPrint('Interstitial ad is not ready.');

      loadAd();
      return;
    }

    _interstitialAd = null;

    ad.show();
  }
}