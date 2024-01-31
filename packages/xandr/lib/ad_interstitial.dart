// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import 'package:xandr/xandr.dart';

class InterstitialAd {
  InterstitialAd({
    required XandrController controller,
    this.placementID,
    this.inventoryCode,
    this.customKeywords,
  })  : assert(
          placementID != null || inventoryCode != null,
          'we need either a placementID or an inventoryCode',
        ),
        _controller = controller;

  final XandrController _controller;
  final String? placementID;
  final String? inventoryCode;
  final Map<String, String>? customKeywords;
  bool _hasBeenShown = false;

  bool get hasBeenShown => _hasBeenShown;

  Future<bool> loadAd() {
    return _controller.loadInterstitialAd(
      placementID: placementID,
      inventoryCode: inventoryCode,
      customKeywords: customKeywords,
    );
  }

  Future<bool> show({int? autoDismissDelay}) async {
    if (_hasBeenShown) {
      debugPrint('interstitial ad has already been shown, cannot show again');
      return false;
    }
    final result = await _controller.showInterstitialAd(
      autoDismissDelay: autoDismissDelay,
    );
    if (result) {
      _hasBeenShown = true;
    }
    return result;
  }
}

class XandrInterstitialBuilder extends FutureBuilder<bool> {
  XandrInterstitialBuilder({
    required InterstitialAd interstitialAd,
    required super.builder,
    super.key,
  }) : super(future: interstitialAd.loadAd());
}
