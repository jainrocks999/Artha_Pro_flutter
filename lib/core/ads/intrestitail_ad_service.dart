import 'dart:io';

import 'package:artha_pro_app/core/constants/ads_unit_key.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class IntrestitailAdService {
  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  VoidCallback? _pendingCallback;

  void loadAd() {
    if (_isLoading || _interstitialAd != null) {
      return;
    }
    _isLoading = true;

    InterstitialAd.load(
      adUnitId: Platform.isIOS
          ? AdsUnitKey.interstitalAdIdTest
          : AdsUnitKey.interstitalAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoading = false;
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            // onAdShowedFullScreenContent: (ad) =>
            //     debugPrint('Interstitial: ✅ showed'),
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;

              final callback = _pendingCallback;
              _pendingCallback = null;

              loadAd();
              callback?.call();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial: failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
              final callback = _pendingCallback;
              _pendingCallback = null;

              loadAd();
              callback?.call();
            },
          );

          if (_pendingCallback != null) {
            final callback = _pendingCallback;
            _pendingCallback = null;

            _showLoadedAd(callback);
          }
        },
        onAdFailedToLoad: (err) {
          _isLoading = false;
          _interstitialAd = null;
          debugPrint('Interstitial failed to load: $err');
         

          final callback = _pendingCallback;
          _pendingCallback = null;
          callback?.call();
        },
      ),
    );
  }

  void showAd({VoidCallback? onAdDismissed}) {
    if (_interstitialAd != null) {
      _showLoadedAd(onAdDismissed);
      return;
    }
    _pendingCallback = onAdDismissed;
    loadAd();
  }

  void _showLoadedAd(VoidCallback? callback) {
    final ad = _interstitialAd;

    if (ad == null) {
      callback?.call();
      return;
    }
    _interstitialAd = null;
    _pendingCallback = callback;
    ad.show();
  }

  void dispose() {
    _pendingCallback = null;
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
