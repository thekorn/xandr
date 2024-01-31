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
