// TODO(thekorn): move to somewhere else

/// Represents the size of an ad.
///
/// Use this class to define the dimensions of an ad.
class AdSize {
  /// Represents the size of an ad.
  ///
  /// The [AdSize] class is used to specify the width and height of an ad.
  /// It is a value object and is immutable.
  ///
  /// Example usage:
  /// ```dart
  /// AdSize adSize = AdSize(320, 50);
  /// ```
  const AdSize(this.width, this.height);

  /// Represents the width of an ad size.
  final int width;

  /// The height of the ad size.
  final int height;

  /// Converts the [AdSize] object to a JSON representation.
  ///
  /// Returns a [Map] containing the JSON representation of the [AdSize] object.
  /// The keys in the map are of type [String] and the values are of type [int].
  Map<String, int> toJson() => <String, int>{
        'width': width,
        'height': height,
      };
}

/// A typedef representing a map of custom keywords.
///
/// The keys are strings representing the keyword names,
/// and the values are strings representing the keyword values.
typedef CustomKeywords = Map<String, String>;

/// A constant representing the use of demo ads.
const CustomKeywords useDemoAds = {'kw': 'demoads'};
