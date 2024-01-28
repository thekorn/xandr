import 'package:xandr_ios/src/messages.g.dart' as messages;
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

/// The Android implementation of [XandrPlatform].
class XandrIOS extends XandrPlatform {
  final messages.XandrHostApi _api = messages.XandrHostApi();

  /// Registers this class as the default instance of [XandrPlatform]
  static void registerWith() {
    XandrPlatform.instance = XandrIOS();
  }

  @override
  Future<bool> init(int memberId) async {
    return _api.init(memberId: memberId);
  }
}
