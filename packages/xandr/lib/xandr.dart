import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

XandrPlatform get _platform => XandrPlatform.instance;

/// A controller for managing Xandr functionality.
class XandrController {
  /// Creates a new instance of the XandrController class.
  ///
  /// This class is responsible for controlling the Xandr functionality.
  /// It initializes the necessary components and provides methods for
  /// interacting with Xandr.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// XandrController controller = XandrController();
  /// controller.initialize();
  /// controller.start();
  /// ```
  XandrController() {
    _platform.registerEventStream(controller: _eventStreamController);
  }

  final StreamController<BannerAdEvent> _eventStreamController =
      StreamController.broadcast();

  /// Initializes the Xandr SDK.
  ///
  /// [memberId] is the Xandr member ID.
  Future<bool> init(int memberId) async {
    debugPrint('init xandr with memberId=$memberId');
    return _platform.init(memberId);
  }

  /// loads an ad.
  Future<bool> loadAd(int widgetId) async {
    debugPrint('loadAd');
    return _platform.loadAd(widgetId);
  }

  /// loads an interstitial ad.
  Future<bool> loadInterstitialAd({
    String? placementID,
    String? inventoryCode,
    CustomKeywords? customKeywords,
  }) async {
    debugPrint('loadInterstitialAd');
    assert(
      placementID != null || inventoryCode != null,
      'placementID or inventoryCode must not be null',
    );
    return _platform.loadInterstitialAd(
      placementID,
      inventoryCode,
      customKeywords,
    );
  }

  /// shows an interstitial ad.
  Future<bool> showInterstitialAd({Duration? autoDismissDelay}) async {
    debugPrint('showInterstitialAd');
    return _platform.showInterstitialAd(autoDismissDelay);
  }

  /// Listens to the stream of strings and returns a [StreamSubscription] that
  /// can be used to cancel the subscription.
  ///
  /// Example usage:
  /// ```dart
  /// StreamSubscription<BannerAdEvent> subscription = listen();
  /// subscription.cancel();
  /// ```
  StreamSubscription<BannerAdEvent> listen(
    int widgetId,
    void Function(BannerAdEvent) callback,
  ) {
    return _eventStreamController.stream
        .where((event) => event.viewId == widgetId)
        .listen(callback);
  }
}

/// The controller for handling multi ad requests.
class MultiAdRequestController {
  String? _multiAdRequestID;

  /// Returns the request ID associated with the multi-ad request.
  /// If no request ID is available, it returns `null`.
  String? get requestId => _multiAdRequestID;

  /// Initializes the Xandr library.
  ///
  /// Returns a [Future] that completes with a [bool] value indicating whether
  /// the initialization was successful.
  Future<bool> init() async {
    _multiAdRequestID = await _platform.initMultiAdRequest();
    return _multiAdRequestID != null;
  }

  /// Disposes the resources used by this object.
  ///
  /// This method should be called when the object is no longer needed to
  /// release any resources it holds.
  Future<void> dispose() async {
    if (_multiAdRequestID != null) {
      await _platform.disposeMultiAdRequest(_multiAdRequestID!);
    }
  }

  /// Loads ads asynchronously.
  ///
  /// Returns a [Future] that completes with a [bool] value indicating whether
  /// the ads were successfully loaded.
  Future<bool> loadAds() async {
    assert(_multiAdRequestID != null, 'multiAdRequestID must be initialized');
    return _platform.loadAdsForMultiAdRequest(_multiAdRequestID!);
  }
}
