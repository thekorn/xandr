import 'package:flutter/widgets.dart';
import 'package:xandr/xandr.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// Represents an interstitial ad.
class InterstitialAd {
  /// Represents an interstitial ad.
  ///
  /// An interstitial ad is a full-screen ad that appears at natural transition
  /// points in your app,
  /// such as between activities or during the pause between levels in a game.
  /// It covers the entire screen and typically includes a call to action for
  /// the user to interact with.
  InterstitialAd({
    required XandrController controller,
    this.placementID,
    this.inventoryCode,
    this.customKeywords,
  }) : assert(
         placementID != null || inventoryCode != null,
         'we need either a placementID or an inventoryCode',
       ),
       _controller = controller;

  final XandrController _controller;

  /// The ID of the placement for the interstitial ad.
  final String? placementID;

  /// The inventory code for the ad interstitial.
  final String? inventoryCode;

  /// The custom keywords for the ad interstitial.
  final CustomKeywords? customKeywords;
  bool _hasBeenShown = false;

  /// Returns a boolean value indicating whether the interstitial ad has
  /// been shown.
  bool get hasBeenShown => _hasBeenShown;

  /// Loads the ad asynchronously.
  ///
  /// Returns a [Future] that completes with a [bool] value indicating
  /// whether the ad was successfully loaded.
  Future<bool> loadAd() {
    return _controller.loadInterstitialAd(
      placementID: placementID,
      inventoryCode: inventoryCode,
      customKeywords: customKeywords,
    );
  }

  /// Shows the interstitial ad.
  ///
  /// Returns a [Future] that completes with a [bool] value indicating whether
  /// the ad was successfully shown.
  /// If the ad has already been shown, this method will return false
  /// immediately, as an interstitial ad can only be shown once.
  /// The [autoDismissDelay] parameter specifies the duration after which the
  /// ad should automatically dismiss.
  /// If no [autoDismissDelay] is provided, the ad will not automatically
  /// dismiss.
  Future<bool> show({Duration? autoDismissDelay}) async {
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

/// A builder class for creating Xandr interstitial ads.
///
/// This class extends the [FutureBuilder] class and is used to build
/// interstitial ads for the Xandr ad platform. It takes a boolean future
/// as its generic type parameter and builds the ad based on the future's
/// value. The future should represent the loading state of the ad.
class XandrInterstitialBuilder extends FutureBuilder<bool> {
  /// A builder class for creating Xandr interstitial ads.
  ///
  /// Use this builder to customize the properties of the interstitial ad
  /// before displaying it.
  XandrInterstitialBuilder({
    required InterstitialAd interstitialAd,
    required super.builder,
    super.key,
  }) : super(future: interstitialAd.loadAd());
}
