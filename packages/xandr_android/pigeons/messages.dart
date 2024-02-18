// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

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
    kotlinOut: 'android/src/main/kotlin/de/thekorn/xandr/Xandr.g.kt',
    kotlinOptions: KotlinOptions(),
  ),
)
@HostApi()
abstract class XandrHostApi {
  @async
  bool init({
    required int memberId,
  });

  @async
  bool loadAd({
    required int widgetId,
  });

  @async
  bool loadInterstitialAd({
    required int widgetId,
    String? placementID,
    String? inventoryCode,
    Map<String, String>? customKeywords,
  });

  @async
  bool showInterstitialAd({int? autoDismissDelay});
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
}
