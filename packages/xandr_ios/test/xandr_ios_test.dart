import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xandr_ios/xandr_ios.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('XandrIOS', () {
    const kPlatformName = 'iOS';
    late XandrIOS xandr;
    late List<MethodCall> log;

    setUp(() async {
      xandr = XandrIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(xandr.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      XandrIOS.registerWith();
      expect(XandrPlatform.instance, isA<XandrIOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await xandr.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
