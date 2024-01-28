import 'dart:async';

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
  void registerEventStream({required StreamController<String> controller}) {
    messages.XandrFlutterApi.setup(
      XandrEventHandler(controller: controller),
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
  const XandrEventHandler({required StreamController<String> controller})
      : _controller = controller;

  final StreamController<String> _controller;

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
    _controller.add('xandr.onAdLoaded');
  }

  @override
  void onAdLoadedError(int viewId, String reason) {
    debugPrint("xandr.onAdLoadedError: $viewId, reason='$reason'");
    _controller.add('xandr.onAdLoadedError');
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
    _controller.add('xandr.onNativeAdLoaded');
  }

  @override
  void onNativeAdLoadedError(int viewId, String reason) {
    debugPrint("xandr.onNativeAdLoadedError: $viewId, reason='$reason'");
    _controller.add('xandr.onNativeAdLoadedError');
  }
}
