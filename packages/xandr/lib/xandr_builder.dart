import 'package:flutter/widgets.dart';
import 'package:xandr/xandr.dart';

/// A builder class for Xandr that extends [FutureBuilder].
///
/// This class is responsible for building Xandr and handling the asynchronous
/// result of type [bool] which is returned by the [XandrController.init]
/// method and indicates success or failure of the initialization.
class XandrBuilder extends FutureBuilder<bool> {
  /// A builder class for creating Xandr objects.
  ///
  /// Use this class to conveniently build Xandr objects with the desired
  /// parameters.
  XandrBuilder({
    required XandrController controller,
    required super.builder,
    required int memberId,
    super.key,
  }) : super(future: controller.init(memberId));
}
