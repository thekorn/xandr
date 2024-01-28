import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// An implementation of [XandrPlatform] that uses method channels.
class MethodChannelXandr extends XandrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xandr');

  @override
  Future<bool> init(int memberId) async {
    return (await methodChannel.invokeMethod<bool>('init', [memberId]))!;
  }
}
