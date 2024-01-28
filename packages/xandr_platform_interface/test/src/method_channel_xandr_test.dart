import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xandr_platform_interface/src/method_channel_xandr.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannelXandr', () {
    late MethodChannelXandr methodChannelXandr;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelXandr = MethodChannelXandr();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelXandr.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannelXandr.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
