import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xandr_android/xandr_android.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('XandrAndroid', () {
    const kPlatformName = 'Android';
    late XandrAndroid xandr;
    late List<MethodCall> log;

    setUp(() async {
      xandr = XandrAndroid();

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
      XandrAndroid.registerWith();
      expect(XandrPlatform.instance, isA<XandrAndroid>());
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
