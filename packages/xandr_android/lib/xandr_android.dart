import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// The Android implementation of [XandrPlatform].
class XandrAndroid extends XandrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xandr_android');

  /// Registers this class as the default instance of [XandrPlatform]
  static void registerWith() {
    XandrPlatform.instance = XandrAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
