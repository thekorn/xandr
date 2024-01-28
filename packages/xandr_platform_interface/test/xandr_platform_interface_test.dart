import 'package:flutter_test/flutter_test.dart';
import 'package:xandr_platform_interface/xandr_platform_interface.dart';

class XandrMock extends XandrPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('XandrPlatformInterface', () {
    late XandrPlatform xandrPlatform;

    setUp(() {
      xandrPlatform = XandrMock();
      XandrPlatform.instance = xandrPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await XandrPlatform.instance.getPlatformName(),
          equals(XandrMock.mockPlatformName),
        );
      });
    });
  });
}
