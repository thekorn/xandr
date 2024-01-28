import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

XandrPlatform get _platform => XandrPlatform.instance;

/// A controller for managing Xandr functionality.
class XandrController {
  /// Creates a new instance of the XandrController class.
  ///
  /// This class is responsible for controlling the Xandr functionality.
  /// It initializes the necessary components and provides methods for
  /// interacting with Xandr.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// XandrController controller = XandrController();
  /// controller.initialize();
  /// controller.start();
  /// ```
  XandrController() {
    _platform.registerEventStream(controller: _eventStreamController);
  }

  final StreamController<String> _eventStreamController =
      StreamController.broadcast();

  /// Initializes the Xandr SDK.
  ///
  /// [memberId] is the Xandr member ID.
  Future<bool> init(int memberId) async {
    debugPrint('init xandr with memberId=$memberId');
    return _platform.init(memberId);
  }

  /// Listens to the stream of strings and returns a [StreamSubscription] that
  /// can be used to cancel the subscription.
  ///
  /// Example usage:
  /// ```dart
  /// StreamSubscription<String> subscription = listen();
  /// subscription.cancel();
  /// ```
  StreamSubscription<String> listen(
    int widgetId,
    void Function(String) callback,
  ) {
    return _eventStreamController.stream
        //.where((event) => event.startsWith('$widgetId:'))
        .listen(callback);
  }
}
