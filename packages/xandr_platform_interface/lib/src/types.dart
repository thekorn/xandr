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

/// A typedef representing a map of custom keywords.
///
/// The keys are strings representing the keyword names,
/// and the values are strings representing the keyword values.
typedef CustomKeywords = Map<String, String>;

/// A constant representing the use of demo ads.
const CustomKeywords useDemoAds = {'kw': 'demoads'};

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
