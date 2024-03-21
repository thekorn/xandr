import 'package:flutter/widgets.dart';
import 'package:xandr/xandr.dart';

/// A builder class for creating multi-ad requests.
///
/// This class extends the [FutureBuilder] class and provides methods for
/// building and sending multi-ad requests. It allows you to easily create and
/// manage multiple ad requests in a single operation.
class MultiAdRequestBuilder extends FutureBuilder<bool> {
  /// A builder class for creating a multi-ad request.
  ///
  /// Use this class to build a multi-ad request by adding individual ad
  /// requests and specifying the desired ad unit sizes, targeting criteria,
  /// and other parameters.
  MultiAdRequestBuilder({
    required MultiAdRequestController controller,
    required super.builder,
    super.key,
  }) : super(future: controller.init());
}
