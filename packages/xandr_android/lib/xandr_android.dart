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
  void registerEventDelegate() {
    messages.XandrFlutterApi.setup(
      const XandrEventHandler(),
    );
  }

  @override
  Future<bool> init(int memberId) async {
    return _api.init(memberId: memberId);
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
  const XandrEventHandler();

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
  }

  @override
  void onAdLoadedError(int viewId) {
    debugPrint('onAdLoadedError: $viewId');
  }

  @override
  void onNativeAdLoaded(int viewId) {
    debugPrint('onNativeAdLoaded: $viewId');
  }

  @override
  void onNativeAdLoadedError(int viewId) {
    debugPrint('onNativeAdLoadedError: $viewId');
  }
}
