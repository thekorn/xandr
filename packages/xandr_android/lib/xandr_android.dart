import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:xandr_android/src/messages.g.dart' as messages;
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// The Android implementation of [XandrPlatform].
class XandrAndroid extends XandrPlatform {
  final messages.XandrHostApi _api = messages.XandrHostApi();

  /// Registers this class as the default instance of [XandrPlatform]
  static void registerWith() {
    XandrPlatform.instance = XandrAndroid();
  }

  @override
  void registerEventStream({
    required StreamController<BannerAdEvent> controller,
  }) {
    messages.XandrFlutterApi.setup(
      XandrEventHandler(controller: controller),
    );
  }

  @override
  Future<bool> init(int memberId) async {
    return _api.init(memberId: memberId);
  }

  @override
  Future<bool> loadInterstitialAd(
    String? placementID,
    String? inventoryCode,
    CustomKeywords? customKeywords,
  ) async {
    final rng = Random();
    final widgetId = rng.nextInt(1000);
    return _api.loadInterstitialAd(
      widgetId: widgetId,
      placementID: placementID,
      inventoryCode: inventoryCode,
      customKeywords: customKeywords,
    );
  }

  @override
  Future<bool> showInterstitialAd(int? autoDismissDelay) {
    return _api.showInterstitialAd(autoDismissDelay: autoDismissDelay);
  }
}

/// A class that implements the XandrFlutterApi interface for handling Xandr
/// events.
class XandrEventHandler implements messages.XandrFlutterApi {
  /// A class representing a Xandr event handler.
  ///
  /// This class is used to handle events related to Xandr.
  /// It provides a set of methods to handle different types of events.
  ///
  /// Example usage:
  /// ```dart
  /// const XandrEventHandler();
  /// ```
  const XandrEventHandler({required StreamController<BannerAdEvent> controller})
      : _controller = controller;

  final StreamController<BannerAdEvent> _controller;

  @override
  void onAdLoaded(
    int viewId,
    int width,
    int height,
    String creativeId,
    String adType,
    String tagId,
    String auctionId,
    double cpm,
    int memberId,
  ) {
    debugPrint('xandr.onAdLoaded: $viewId, size=${width}x$height, '
        'creativeId=$creativeId, adType=$adType, tagId=$tagId, '
        'auctionId=$auctionId, cpm=$cpm, memberId=$memberId');
    _controller.add(
      BannerAdLoadedEvent(
        width: width,
        height: height,
        viewId: viewId,
        creativeId: creativeId,
        adType: adType,
        tagId: tagId,
        auctionId: auctionId,
        cpm: cpm,
        memberId: memberId,
      ),
    );
  }

  @override
  void onAdLoadedError(int viewId, String reason) {
    debugPrint("xandr.onAdLoadedError: $viewId, reason='$reason'");
    _controller.add(BannerAdLoadedErrorEvent(viewId: viewId, reason: reason));
  }

  @override
  void onNativeAdLoaded(
    int viewId,
    String title,
    String description,
    String imageUrl,
  ) {
    debugPrint("xandr.onNativeAdLoaded: $viewId, title='$title', "
        "description='$description', imageUrl='$imageUrl'");
    _controller.add(
      NativeBannerAdLoadedEvent(
        viewId: viewId,
        title: title,
        description: description,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  void onNativeAdLoadedError(int viewId, String reason) {
    debugPrint("xandr.onNativeAdLoadedError: $viewId, reason='$reason'");
    _controller
        .add(NativeBannerAdLoadedErrorEvent(viewId: viewId, reason: reason));
  }
}

/// Represents an error event for a banner ad.
/// This class is an abstract class that extends [BannerAdEvent].
abstract class BannerAdErrorEvent extends BannerAdEvent {
  /// Represents an event that occurs when a banner ad encounters an error.
  ///
  /// This event provides information about the error that occurred.
  BannerAdErrorEvent({
    required super.viewId,
    required this.reason,
  });

  /// The reason describing the error.
  final String reason;
}

/// Represents an event that is triggered when a banner ad is successfully
/// loaded.
class BannerAdLoadedEvent extends BannerAdEvent {
  /// Represents an event indicating that a banner ad has been loaded.
  ///
  /// This event is triggered when a banner ad is successfully loaded and ready
  /// to be displayed.

  BannerAdLoadedEvent({
    required super.viewId,
    required this.width,
    required this.height,
    required this.creativeId,
    required this.adType,
    required this.tagId,
    required this.auctionId,
    required this.cpm,
    required this.memberId,
  });

  /// The width of the object.
  final int width;

  /// The height of the widget.
  final int height;

  /// The ID of the creative.
  final String creativeId;

  /// The type of the ad.
  final String adType;

  /// The tag ID for Xandr Android.
  final String tagId;

  /// The unique identifier for the auction.
  final String auctionId;

  /// The cost per thousand impressions (CPM) for the Xandr Android package.
  final double cpm;

  /// The member ID.
  final int memberId;
}

/// Represents an event that occurs when a banner ad fails to load.
/// This event is a subclass of [BannerAdErrorEvent].
class BannerAdLoadedErrorEvent extends BannerAdErrorEvent {
  /// Represents an event that occurs when a banner ad fails to load.
  ///
  /// This event is triggered when there is an error while loading a banner ad.
  /// It provides information about the error that occurred.
  BannerAdLoadedErrorEvent({
    required super.viewId,
    required super.reason,
  });
}

/// Represents an event indicating that a native banner ad has been loaded.
/// This event is a subclass of [BannerAdEvent].
class NativeBannerAdLoadedEvent extends BannerAdEvent {
  /// Represents an event indicating that a native banner ad has been loaded.
  ///
  /// This event is triggered when a native banner ad is successfully loaded
  /// and ready to be displayed.
  NativeBannerAdLoadedEvent({
    required super.viewId,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  /// The title which should be shown within the native ad.
  final String title;

  /// The description which should be shown within the native ad.
  final String description;

  /// The URL of the main image within in the native ad.
  final String imageUrl;
}

/// Represents an event that is triggered when a native banner ad fails to load.
/// Extends the [BannerAdErrorEvent] class.
class NativeBannerAdLoadedErrorEvent extends BannerAdErrorEvent {
  /// Represents an event that occurs when a native banner ad fails to load.
  ///
  /// This event is triggered when there is an error while loading a native
  /// banner ad.
  /// It provides information about the error that occurred.
  NativeBannerAdLoadedErrorEvent({
    required super.viewId,
    required super.reason,
  });
}
