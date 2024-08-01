// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

enum HostAPIUserIdSource {
  criteo,
  theTradeDesk,
  netId,
  liveramp,
  uid2,
}

class HostAPIUserId {
  HostAPIUserId({required this.userId, required this.source});
  HostAPIUserIdSource source;
  String userId;
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    //dartTestOut: 'test/test_android_webview.g.dart',
    dartOptions: DartOptions(
      copyrightHeader: <String>[
        //'Copyright 2013 The Flutter Authors. All rights reserved.',
        //'Use of this source code is governed by a BSD-style license that ',
        //'can be found in the LICENSE file.',
      ],
    ),
    swiftOut: 'ios/Classes/pigeons/Xandr.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class XandrHostApi {
  @async
  bool initXandrSdk({
    required int memberId,
    int? publisherId,
  });

  @async
  bool loadInterstitialAd({
    required int widgetId,
    String? placementID,
    String? inventoryCode,
    Map<String, List<String>>? customKeywords,
  });

  @async
  bool showInterstitialAd({int? autoDismissDelay});

  @async
  bool setPublisherUserId(String publisherUserId);

  @async
  String initMultiAdRequest();

  @async
  bool disposeMultiAdRequest(String multiAdRequestID);

  @async
  bool loadAdsForMultiAdRequest(String multiAdRequestID);

  @async
  bool loadAd({
    required int widgetId,
  });

  @async
  String getPublisherUserId();

  @async
  bool setUserIds(List<HostAPIUserId> userIds);

  @async
  List<HostAPIUserId> getUserIds();

  @async
  // ignore: avoid_positional_boolean_parameters
  bool setGDPRConsentRequired(bool isConsentRequired);

  @async
  bool setGDPRConsentString(String consentString);

  @async
  bool setGDPRPurposeConsents(String purposeConsents);
}

@FlutterApi()
abstract class XandrFlutterApi {
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
  ) {}
  void onAdLoadedError(int viewId, String reason) {}
  void onNativeAdLoaded(
    int viewId,
    String title,
    String description,
    String imageUrl,
  ) {}
  void onNativeAdLoadedError(int viewId, String reason) {}
  void onAdClicked(int viewId, String url) {}
}
