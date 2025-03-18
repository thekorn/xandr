import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// An implementation of [XandrPlatform] that uses method channels.
class MethodChannelXandr extends XandrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xandr');

  @override
  Future<bool> init(
    int memberId, {
    int? publisherId,
    bool testMode = false,
  }) async {
    return (await methodChannel.invokeMethod<bool>('init', [memberId]))!;
  }

  @override
  Future<void> resetController() async {
    await methodChannel.invokeMethod<void>('resetController');
  }

  @override
  Future<bool> loadAd(int widgetId) async {
    return (await methodChannel.invokeMethod<bool>('loadAd'))!;
  }

  @override
  Future<bool> loadInterstitialAd(
    String? placementID,
    String? inventoryCode,
    CustomKeywords? customKeywords,
  ) async {
    return (await methodChannel.invokeMethod<bool>('loadInterstitialAd', [
      placementID,
      inventoryCode,
      customKeywords,
    ]))!;
  }

  @override
  Future<bool> showInterstitialAd(Duration? autoDismissDelay) async {
    return (await methodChannel.invokeMethod<bool>('showInterstitialAd', [
      autoDismissDelay?.inMilliseconds,
    ]))!;
  }

  @override
  Future<void> setPublisherUserId(String publisherUserId) async {
    await methodChannel
        .invokeMethod<void>('setPublisherUserId', [publisherUserId]);
  }

  @override
  Future<String> getPublisherUserId() async {
    return (await methodChannel.invokeMethod<String>('getPublisherUserId'))!;
  }

  @override
  Future<void> setUserIds(List<UserId> userIds) async {
    await methodChannel.invokeMethod<void>('setUserIds', [userIds]);
  }

  @override
  Future<List<UserId>> getUserIds() async {
    return (await methodChannel
        .invokeMethod<List<UserId>>('getPublisherUserId'))!;
  }
}
