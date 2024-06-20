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
  XandrController() {
    _platform.registerEventStream(controller: _eventStreamController);
  }

  /// A completer that indicates whether the initialization is complete or not.
  final Completer<bool> isInitialized = Completer();

  final StreamController<BannerAdEvent> _eventStreamController =
      StreamController.broadcast();

  /// Initializes the Xandr SDK.
  ///
  /// [memberId] is the Xandr member ID.
  Future<bool> init(int memberId, {int? publisherId}) async {
    debugPrint('init xandr with memberId=$memberId publisherId=$publisherId');
    if (isInitialized.isCompleted) {
      return isInitialized.future;
    }
    final result = await _platform.init(memberId, publisherId: publisherId);
    isInitialized.complete(result);
    return result;
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
  /// Controller for handling multi ad requests.
  ///
  /// This controller is responsible for managing multiple ad requests
  /// and coordinating with the XandrController.
  MultiAdRequestController({required XandrController controller})
      : _controller = controller;

  String? _multiAdRequestID;
  final XandrController _controller;

  /// Returns the request ID associated with the multi-ad request.
  /// If no request ID is available, it returns `null`.
  String? get requestId => _multiAdRequestID;

  /// A completer that indicates whether the initialization is complete or not.
  final Completer<bool> isInitialized = Completer();

  /// Initializes the application when Xandr is ready.
  ///
  /// Returns a [Future] that completes with a boolean value indicating whether
  /// the initialization was successful.
  Future<bool> initWhenXandrIsReady() async {
    if (_controller.isInitialized.isCompleted) {
      return _controller.isInitialized.future;
    }
    await _controller.isInitialized.future;
    return init();
  }

  /// Initializes the Xandr library.
  ///
  /// Returns a [Future] that completes with a [bool] value indicating whether
  /// the initialization was successful.
  Future<bool> init() async {
    if (isInitialized.isCompleted) {
      return isInitialized.future;
    }
    _multiAdRequestID = await _platform.initMultiAdRequest();
    final result = _multiAdRequestID != null;
    isInitialized.complete(result);
    return result;
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
