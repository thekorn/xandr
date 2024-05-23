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

  /// Registers the event stream.
  void registerEventStream({
    required StreamController<BannerAdEvent> controller,
  }) {
    _instance.registerEventStream(controller: controller);
  }

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [XandrPlatform] when they register themselves.
  static set instance(XandrPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<bool> init(int memberId) {
    return _instance.init(memberId);
  }

  /// loads an ad.
  Future<bool> loadAd(int widgetId) async {
    return _instance.loadAd(widgetId);
  }

  /// loads an interstitial ad.
  Future<bool> loadInterstitialAd(
    String? placementID,
    String? inventoryCode,
    CustomKeywords? customKeywords,
  ) async {
    return _instance.loadInterstitialAd(
      placementID,
      inventoryCode,
      customKeywords,
    );
  }

  /// Return the current platform name.
  Future<bool> showInterstitialAd(Duration? autoDismissDelay) {
    return _instance.showInterstitialAd(autoDismissDelay);
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
    return _instance.setPublisherUserId(publisherUserId);
  }

  /// Returns the publisher user ID.
  Future<String> getPublisherUserId() {
    return _instance.getPublisherUserId();
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
    return _instance.setUserIds(userIds);
  }

  /// Returns a list of [UserId] objects.
  ///
  /// This method retrieves the user IDs from the platform interface.
  /// The returned list contains instances of the [UserId] class.
  Future<List<UserId>> getUserIds() {
    return _instance.getUserIds();
  }

  /// Initializes a multi ad request.
  ///
  /// Returns a [Future] that completes with a [String] representing the result
  /// of the initialization.
  Future<String> initMultiAdRequest() {
    return _instance.initMultiAdRequest();
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
    return _instance.disposeMultiAdRequest(multiAdRequestID);
  }

  /// Loads ads for a multi ad request with the specified [multiAdRequestID].
  /// Returns a [Future] that completes with a [bool] indicating whether the ads
  /// were successfully loaded.
  Future<bool> loadAdsForMultiAdRequest(String multiAdRequestID) {
    return _instance.loadAdsForMultiAdRequest(multiAdRequestID);
  }

  /// Sets whether GDPR consent is required.
  ///
  /// This method is used to set whether GDPR consent is required for the app.
  /// If `isConsentRequired` is `true`, it means that GDPR consent is required.
  /// If `isConsentRequired` is `false`, it means that GDPR consent is not
  /// required.
  ///
  // ignore: avoid_positional_boolean_parameters
  Future<void> setGDPRConsentRequired(bool isConsentRequired) {
    return _instance.setGDPRConsentRequired(isConsentRequired);
  }

  /// Sets the GDPR consent string.
  ///
  /// The [consentString] parameter is a string representing the user's consent
  /// for GDPR.
  /// This method is used to set the GDPR consent string for the application.
  /// It returns a [Future] that completes when the consent string is set.
  Future<void> setGDPRConsentString(String consentString) {
    return _instance.setGDPRConsentString(consentString);
  }

  /// Sets the GDPR purpose consents.
  ///
  /// The [purposeConsents] parameter is a string representing the purpose
  /// consents for GDPR compliance. A valid Binary String: The '0' or '1' at
  /// position n – where n's indexing begins at 0 – indicates the consent status
  /// for purpose ID n+1; false and true respectively. eg. '1' at index 0 is
  /// consent true for purpose ID 1
  ///
  /// Returns a [Future] that completes when the purpose consents are set.
  Future<void> setGDPRPurposeConsents(String purposeConsents) {
    return _instance.setGDPRPurposeConsents(purposeConsents);
  }
}
