import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:xandr/xandr.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

class MockXandrPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements XandrPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Xandr', () {
    late XandrPlatform xandrPlatform;

    setUp(() {
      xandrPlatform = MockXandrPlatform();
      XandrPlatform.instance = xandrPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => xandrPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => xandrPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
