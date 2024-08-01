/// Represents an event related to a banner ad.
///
/// This class is used to encapsulate information about a banner ad event,
/// such as the view ID associated with the event.
abstract class BannerAdEvent {
  /// Creates a new instance of [BannerAdEvent] with the specified [viewId].
  BannerAdEvent({required this.viewId});

  /// The unique identifier for the view.
  final int viewId;
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

/// Represents an ad clicked event
/// This class is an abstract class that extends [BannerAdEvent].
class BannerAdClickedEvent extends BannerAdEvent {
  /// Event that occurs when an ad is clicked
  BannerAdClickedEvent({
    required super.viewId,
    required this.url,
  });

  /// The URL of the ad
  final String url;
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

/// A typedef representing a map of custom keywords.
///
/// The keys are strings representing the keyword names,
/// and the values are list of strings representing the keyword values.
typedef CustomKeywords = Map<String, List<String>>;

/// A constant representing the use of demo ads.
const CustomKeywords useDemoAds = {
  'kw': ['demoads'],
};

/// Enum representing the source of a user ID.
enum UserIdSource {
  /// User ID source: Criteo.
  criteo,

  /// User ID source: The Trade Desk.
  theTradeDesk,

  /// User ID source: NetId.
  netId,

  /// User ID source: LiveRamp.
  liveramp,

  /// User ID source: UID2.
  uid2,
}

/// Represents a user ID with its source.
class UserId {
  /// Creates a new instance of [UserId].
  ///
  /// The [userId] parameter is the user ID value.
  /// The [source] parameter is the source of the user ID.
  UserId({required this.userId, required this.source});

  /// Creates a [UserId] object for Criteo with the given [userId].
  factory UserId.criteo(String userId) {
    return UserId(userId: userId, source: UserIdSource.criteo);
  }

  /// Creates a [UserId] object for The Trade Desk with the given [userId].
  factory UserId.theTradeDesk(String userId) {
    return UserId(userId: userId, source: UserIdSource.theTradeDesk);
  }

  /// Creates a [UserId] object for netId with the given [userId].
  factory UserId.netId(String userId) {
    return UserId(userId: userId, source: UserIdSource.netId);
  }

  /// Creates a [UserId] object for liveramp with the given [userId].
  factory UserId.liveramp(String userId) {
    return UserId(userId: userId, source: UserIdSource.liveramp);
  }

  /// Creates a [UserId] object for uid2 with the given [userId].
  factory UserId.uid2(String userId) {
    return UserId(userId: userId, source: UserIdSource.uid2);
  }

  /// The user ID.
  final String userId;

  /// The source of the user ID.
  final UserIdSource source;
}
