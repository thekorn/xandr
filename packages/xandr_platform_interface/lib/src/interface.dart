import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:xandr_platform_interface/src/method_channel.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// The interface that implementations of xandr must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `Xandr`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [XandrPlatform] methods.
abstract class XandrPlatform extends PlatformInterface {
  /// Constructs a XandrPlatform.
  XandrPlatform() : super(token: _token);

  static final Object _token = Object();

  static XandrPlatform _instance = MethodChannelXandr();

  /// The default instance of [XandrPlatform] to use.
  ///
  /// Defaults to [MethodChannelXandr].
  static XandrPlatform get instance => _instance;

  /// Registers the event delegate.
  void registerEventStream({
    required StreamController<BannerAdEvent> controller,
  }) {
    throw UnimplementedError(
      'registerEventDelegate() has not been implemented.',
    );
  }

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [XandrPlatform] when they register themselves.
  static set instance(XandrPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<bool> init(int memberId) {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// loads an ad.
  Future<bool> loadAd(int widgetId) async {
    throw UnimplementedError('loadAd() has not been implemented.');
  }

  /// loads an interstitial ad.
  Future<bool> loadInterstitialAd(
    String? placementID,
    String? inventoryCode,
    CustomKeywords? customKeywords,
  ) async {
    throw UnimplementedError('loadInterstitialAd() has not been implemented.');
  }

  /// Return the current platform name.
  Future<bool> showInterstitialAd(Duration? autoDismissDelay) {
    throw UnimplementedError('showInterstitialAd() has not been implemented.');
  }

  /// Sets the publisher user ID.
  ///
  /// This method is used to set the publisher user ID for the Xandr platform
  /// interface. The publisher user ID is a unique identifier for the
  /// publisher's user.
  ///
  /// Parameters:
  /// - `publisherUserId`: The publisher user ID to be set.
  ///
  /// Example usage:
  /// ```dart
  /// setPublisherUserId('123456789');
  /// ```
  Future<void> setPublisherUserId(String publisherUserId) {
    throw UnimplementedError('setPublisherUserId() has not been implemented.');
  }

  /// Returns the publisher user ID.
  Future<String> getPublisherUserId() {
    throw UnimplementedError('getPublisherUserId() has not been implemented.');
  }

  /// Sets the user IDs for the current user.
  ///
  /// The [userIds] parameter is a list of [UserId] objects representing
  /// the user IDs to be set.
  ///
  /// Example usage:
  /// ```dart
  /// List<UserId> userIds = [
  ///   UserId.netId(id: '123'),
  ///   UserId.criteo(id: '456'),
  /// ];
  /// setUserIds(userIds);
  /// ```
  Future<void> setUserIds(List<UserId> userIds) {
    throw UnimplementedError('setUserIds() has not been implemented.');
  }

  /// Returns a list of [UserId] objects.
  ///
  /// This method retrieves the user IDs from the platform interface.
  /// The returned list contains instances of the [UserId] class.
  Future<List<UserId>> getUserIds() {
    throw UnimplementedError('getUserIds() has not been implemented.');
  }

  /// Initializes a multi ad request.
  ///
  /// Returns a [Future] that completes with a [String] representing the result
  /// of the initialization.
  Future<String> initMultiAdRequest() {
    throw UnimplementedError('initMultiAdRequest() has not been implemented.');
  }

  /// Disposes a multi ad request with the specified [multiAdRequestID].
  ///
  /// This method is used to clean up and release resources associated with
  /// a multi ad request.
  ///
  /// Parameters:
  ///   - [multiAdRequestID]: The ID of the multi ad request to dispose.
  ///
  /// Returns:
  ///   - A [Future] that completes when the multi ad request is disposed.
  Future<void> disposeMultiAdRequest(String multiAdRequestID) {
    throw UnimplementedError(
      'disposeMultiAdRequest() has not been implemented.',
    );
  }

  /// Loads ads for a multi ad request with the specified [multiAdRequestID].
  /// Returns a [Future] that completes with a [bool] indicating whether the ads
  /// were successfully loaded.
  Future<bool> loadAdsForMultiAdRequest(String multiAdRequestID) {
    throw UnimplementedError(
      'loadAdsForMultiAdRequest() has not been implemented.',
    );
  }
}
