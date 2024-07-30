import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';

import 'package:flutter/foundation.dart';
import 'package:xandr_android/src/messages.g.dart' as messages;
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

extension on messages.HostAPIUserId {
  UserId toUserId() {
    switch (source) {
      case messages.HostAPIUserIdSource.criteo:
        return UserId.criteo(userId);
      case messages.HostAPIUserIdSource.theTradeDesk:
        return UserId.theTradeDesk(userId);
      case messages.HostAPIUserIdSource.netId:
        return UserId.netId(userId);
      case messages.HostAPIUserIdSource.liveramp:
        return UserId.liveramp(userId);
      case messages.HostAPIUserIdSource.uid2:
        return UserId.uid2(userId);
    }
  }
}

extension on UserIdSource {
  messages.HostAPIUserIdSource toHostAPIUserIdSource() {
    switch (this) {
      case UserIdSource.criteo:
        return messages.HostAPIUserIdSource.criteo;
      case UserIdSource.theTradeDesk:
        return messages.HostAPIUserIdSource.theTradeDesk;
      case UserIdSource.netId:
        return messages.HostAPIUserIdSource.netId;
      case UserIdSource.liveramp:
        return messages.HostAPIUserIdSource.liveramp;
      case UserIdSource.uid2:
        return messages.HostAPIUserIdSource.uid2;
    }
  }
}

extension on UserId {
  messages.HostAPIUserId toHostAPIUserId() {
    return messages.HostAPIUserId(
      userId: userId,
      source: source.toHostAPIUserIdSource(),
    );
  }
}

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
    messages.XandrFlutterApi.setUp(
      XandrEventHandler(controller: controller),
    );
  }

  @override
  Future<bool> init(int memberId, {int? publisherId}) async {
    return _api.init(memberId: memberId, publisherId: publisherId);
  }

  @override
  Future<bool> loadAd(int widgetId) async {
    return _api.loadAd(
      widgetId: widgetId,
    );
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
  Future<bool> showInterstitialAd(Duration? autoDismissDelay) {
    return _api.showInterstitialAd(
      autoDismissDelay: autoDismissDelay?.inSeconds,
    );
  }

  @override
  Future<void> setPublisherUserId(String publisherUserId) {
    return _api.setPublisherUserId(publisherUserId);
  }

  @override
  Future<String> getPublisherUserId() {
    return _api.getPublisherUserId();
  }

  @override
  Future<void> setUserIds(List<UserId> userIds) {
    return _api.setUserIds(
      userIds.map((uId) => uId.toHostAPIUserId()).toList(),
    );
  }

  @override
  Future<List<UserId>> getUserIds() async {
    final userIds = await _api.getUserIds();
    return userIds.whereNotNull().map((uId) => uId.toUserId()).toList();
  }

  @override
  Future<String> initMultiAdRequest() {
    return _api.initMultiAdRequest();
  }

  @override
  Future<void> disposeMultiAdRequest(String multiAdRequestID) {
    return _api.disposeMultiAdRequest(multiAdRequestID);
  }

  @override
  Future<bool> loadAdsForMultiAdRequest(String multiAdRequestID) {
    return _api.loadAdsForMultiAdRequest(multiAdRequestID);
  }

  @override
  Future<void> setGDPRConsentRequired(bool isConsentRequired) {
    return _api.setGDPRConsentRequired(isConsentRequired);
  }

  @override
  Future<void> setGDPRConsentString(String consentString) {
    return _api.setGDPRConsentString(consentString);
  }

  @override
  Future<void> setGDPRPurposeConsents(String purposeConsents) {
    return _api.setGDPRPurposeConsents(purposeConsents);
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
